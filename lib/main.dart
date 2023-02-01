import 'package:app_meditation/ui/res/app_theme.dart';
import 'package:app_meditation/ui/ui/main_screen.dart';
import 'package:app_meditation/ui/ui/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>ScreenUtilInit(
    builder: (context, child)=>
      MaterialApp(
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
        home: OnboardingScreen(),
      )
  );
}
