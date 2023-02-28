import 'dart:async';

import 'package:app_meditation/domain/urls/config.dart';
import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/firebase_options.dart';
import 'package:app_meditation/ui/res/app_theme.dart';
import 'package:app_meditation/ui/ui/auth/auth_screen.dart';
import 'package:app_meditation/ui/ui/home/home_screen.dart';
import 'package:app_meditation/ui/ui/onboarding/ui/onboarding_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// final appsFlyerOptions = AppsFlyerOptions(
//   afDevKey: AppConfig.afDevKey,
//   appId: AppConfig.appID,
//   showDebug: true,
//   disableAdvertisingIdentifier: false,
// );
// final appsflyer = AppsflyerSdk(appsFlyerOptions);
late final FirebaseApp fbApp;
late final FirebaseAnalytics analytics;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initPlatformState();
  await Hive.initFlutter();
  Hive.registerAdapter<UserData>(UserDataAdapter());
  await Hive.openBox<UserData>('user');
  await Hive.openBox<bool>('onbseen');
  // await Hive.box<bool>('onbseen').clear();
  // await Hive.box<UserData>('user').clear();
  if (Hive.box<bool>('onbseen').isEmpty == true) {
    await Hive.box<bool>('onbseen').put('onbseen', false);
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
              ? Hive.box<UserData>('user').isEmpty == true
                  ? OnboardingScreen()
                  : const AuthScreen()
              : Hive.box<UserData>('user').isEmpty == true
                  ? const AuthScreen()
                  : const HomeScreen(),
        ),
      );
}

Future<void> _initPlatformState() async {
  unawaited(OneSignal.shared.setAppId(AppConfig.oneSignalApiKey).then((value) =>
      OneSignal.shared
          .promptUserForPushNotificationPermission()
          .then((accepted) {
        debugPrint(accepted.toString(),);
      }),),);
  fbApp=await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  analytics=FirebaseAnalytics.instance;
  try{
    // await analytics.isSupported().then((value) => debugPrint('analytics : $value'));
    await analytics.logAppOpen();
  }catch(e){
    debugPrint(e.toString());
  }
}
