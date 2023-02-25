import 'dart:async';

import 'package:app_meditation/domain/urls/config.dart';
import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/ui/res/app_theme.dart';
import 'package:app_meditation/ui/ui/auth/auth_screen.dart';
import 'package:app_meditation/ui/ui/home/home_screen.dart';
import 'package:app_meditation/ui/ui/onboarding/ui/onboarding_screen.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

final appsFlyerOptions = AppsFlyerOptions(
    afDevKey: AppConfig.afDevKey,
    appId: AppConfig.appID,
    showDebug: true,
    disableAdvertisingIdentifier: false,
    // Optional field
    disableCollectASA: false);
final appsflyer = AppsflyerSdk(appsFlyerOptions);

Future<void> main() async {
  // AppMetrica.runZoneGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initPlatformState();
  // await AppMetrica.activate(
  //   const AppMetricaConfig(AppConfig.yandexApiKey),
  // );
  await Hive.initFlutter();
  Hive.registerAdapter<UserData>(UserDataAdapter());
  await Hive.openBox<UserData>('user');
  await Hive.openBox<bool>('onbseen');
  // await Hive.box<bool>('onbseen').clear();
  // await Hive.box<UserData>('user').clear();
  if (Hive.box<bool>('onbseen').isEmpty) {
    await Hive.box<bool>('onbseen').put('onbseen', false);
    try {
      unawaited(appsflyer.logEvent('first activation', <String, dynamic>{
        'deviceInfo': await DeviceInformation.deviceIMEINumber,
        'firstActivationDate': DateTime.now().toString(),
      }));
    } catch (e) {
      debugPrint('log error: $e');
    }
    // try {
    //   AppMetrica.reportEventWithMap('first activation', {
    //     'deviceInfo': await DeviceInformation.deviceIMEINumber,
    //     'firstActivationDate': DateTime.now().toString(),
    //   });
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }
  runApp(const App());
}
// }

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
              ? Hive.box<UserData>('user').isEmpty
                  ? OnboardingScreen()
                  : const AuthScreen()
              : Hive.box<UserData>('user').isEmpty
                  ? const AuthScreen()
                  : const HomeScreen(),
        ),
      );
}

Future<void> _initPlatformState() async {
  await OneSignal.shared.setAppId(AppConfig.oneSignalApiKey);
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {
    debugPrint(accepted.toString());
  }); // Optional field
  try {
    await AppsflyerSdk(appsFlyerOptions).initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  } catch (e) {
    debugPrint('AppsFlyer error $e');
  }
}
