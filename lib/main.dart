import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/ui/res/app_theme.dart';
import 'package:app_meditation/ui/ui/main_screen.dart';
import 'package:app_meditation/ui/ui/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<UserData>(UserDataAdapter());
  await Hive.openBox<UserData>('user');
  await Hive.openBox<bool>('onbseen');
  await Hive.box<bool>('onbseen').clear();
  if (Hive.box<bool>('onbseen').isEmpty) {
    await Hive.box<bool>('onbseen').put('onbseen', false);
  }
  if (Hive.box<UserData>('user').isEmpty) {
    await Hive.box<UserData>('user').put(
      'user',
      UserData(name: '', choose: [], phone: ''),
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
            title: 'App meditation',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: Hive.box<bool>('onbseen').values.first == false
                ? OnboardingScreen()
                : const MainScreen(),
          ));
}
