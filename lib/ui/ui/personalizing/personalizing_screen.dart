import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/paywall/paywall_screen.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class PersonalizingScreen extends StatefulWidget {
  const PersonalizingScreen({Key? key}) : super(key: key);

  @override
  State<PersonalizingScreen> createState() => _PersonalizingScreenState();
}

class _PersonalizingScreenState extends State<PersonalizingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double loadingData = 0.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
        if (controller.isCompleted) {
          Navigator.push(
            context,
            PageTransition<Widget>(
              child: const PayWallScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        }
      });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applocale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            const BgDecoration(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          applocale.personalizingContent,
                          textAlign: TextAlign.center,
                          style: AppTypography.mainStyle.copyWith(
                            fontSize: 34.w,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 77,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          value: controller.value,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                          backgroundColor: AppColors.white.withOpacity(0.1),
                          // color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
