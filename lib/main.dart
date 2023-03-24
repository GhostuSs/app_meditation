import 'dart:async';
import 'dart:io';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:app_meditation/domain/urls/config.dart';
import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/ui/res/app_theme.dart';
import 'package:app_meditation/ui/ui/home/home_screen.dart';
import 'package:app_meditation/ui/ui/onboarding/ui/onboarding_screen.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

late final Amplitude analytics;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  bool firstActivation = false;
  Hive.registerAdapter<UserData>(UserDataAdapter());
  await Hive.openBox<UserData>('user');
  await Hive.openBox<bool>('onbseen');
  await Hive.openBox<bool>('premium');
  // await Hive.box<UserData>('user').clear();
  // await Hive.box<bool>('onbseen').clear();
  // await Hive.box<bool>('premium').clear();
  if (Hive.box<bool>('premium').isEmpty == true) {
    await Hive.box<bool>('premium').put('premium', false);
  }
  if (Hive.box<bool>('onbseen').isEmpty == true) {
    await Hive.box<bool>('onbseen').put('onbseen', false);
  }

  if (Hive.box<UserData>('user').isEmpty == true) {
    await Hive.box<UserData>('user').put(
      'user',
      UserData(
        onbpassed: false,
        firstActivation: true,
        authcompleted: false,
      ),
    );
    firstActivation = true;
  }
  await _initPlatformState();
  if (firstActivation) {
    unawaited(
      analytics.logEvent('first_activation', eventProperties: <String, dynamic>{
        'date': DateTime.now().toString(),
        'timezone': DateTime.now().timeZoneName,
      }),
    );
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        builder: (context, child) => MaterialApp(
            theme: AppTheme.mainTheme,
            debugShowCheckedModeBanner: false,
            title: 'Soulmates',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: Hive.box<bool>('onbseen').values.first == false
                ? Hive.box<UserData>('user').values.first.name == null
                    ? OnboardingScreen()
                    : const HomeScreen()
                : const HomeScreen()),
      );
}

Future<void> _initPlatformState() async {
  unawaited(
    OneSignal.shared.setAppId(AppConfig.oneSignalApiKey).then(
          (value) => OneSignal.shared
              .promptUserForPushNotificationPermission()
              .then((accepted) {
            debugPrint(
              accepted.toString(),
            );
          }),
        ),
  );
  try {
    analytics = Amplitude.getInstance(instanceName: 'soulmates');
    final appsFlyerOptions = AppsFlyerOptions(
        afDevKey: AppConfig.afDevKey,
        appId: Platform.isIOS ? AppConfig.iosAppID : AppConfig.androidAppID);
    unawaited(
      AppsflyerSdk(appsFlyerOptions).initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      ),
    );
    final Map<String, dynamic> appOpenedEvent = <String, dynamic>{
      'opened_at': DateTime.now().toString(),
      'auth_completed': Hive.box<UserData>('user').values.first.authcompleted,
      'onboarding_passed': Hive.box<UserData>('user').values.first.onbpassed,
      'first_activation':
          Hive.box<UserData>('user').values.first.firstActivation,
      'subscription': Hive.box<bool>('premium').values.first.toString(),
    };
    await analytics.init(AppConfig.amplitudeKey);
    await analytics.logEvent('app_opened', eventProperties: appOpenedEvent);
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}
