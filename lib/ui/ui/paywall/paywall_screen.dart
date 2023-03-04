import 'dart:async';

import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/main.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/home/home_screen.dart';
import 'package:app_meditation/ui/ui/paywall/uikit/info_text.dart';
import 'package:app_meditation/ui/ui/paywall/uikit/subscribe_widget.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:app_meditation/ui/uikit/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

class PayWallScreen extends StatefulWidget {
  const PayWallScreen({Key? key}) : super(key: key);

  @override
  State<PayWallScreen> createState() => _PayWallScreenState();
}

class _PayWallScreenState extends State<PayWallScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final applocale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: Stack(
        children: [
          const BgDecoration(),
          SafeArea(
            bottom: false,
            minimum: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        unawaited(analytics.logEvent('subsription',
                            eventProperties: <String, dynamic>{
                              'subscription': 'skipped',
                              'date': DateTime.now().toString(),
                              'timezone': DateTime.now().timeZoneName
                            }));
                        await Navigator.push<Widget>(
                          context,
                          PageTransition(
                            child: const HomeScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.clear,
                        color: AppColors.white,
                        size: 20.h,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  Assets.imagesPaywall,
                  height: MediaQuery.of(context).size.height/4.5,
                ),
                Text(
                  applocale.trySoulmates,
                  textAlign: TextAlign.center,
                  style: AppTypography.mainStyle.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30.5.sp,
                      color: AppColors.white),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  child: Column(
                    children: [
                      InfoText(label: applocale.benefit1),
                      InfoText(label: applocale.benefit2),
                      InfoText(label: applocale.benefit3),
                      InfoText(label: applocale.benefit4),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      applocale.after7days,
                      style: AppTypography.mainStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 14.5.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubscribeWidget(
                      onTap: selected != 0
                          ? () => setState(() => selected = 0)
                          : () {},
                      price: '39.99',
                      isSelected: selected == 0,
                      header: applocale.annual,
                      footer: '\$3.99 ${applocale.perMonth}',
                      bestValue: true,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    SubscribeWidget(
                      onTap: selected != 1
                          ? () => setState(() => selected = 1)
                          : () {},
                      price: '4.99',
                      isSelected: selected == 1,
                      header: applocale.monthly,
                      footer: applocale.perMonth,
                    )
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                MainButton(
                  label: applocale.tryForFreeAndSubscribe,
                  onTap: navigateToMain,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> navigateToMain() async {
    unawaited(
        analytics.logEvent('subscription', eventProperties: <String, dynamic>{
      'subscription': 'chosen',
      'type': selected == 0 ? 'Annual' : 'Monthly',
      'date': DateTime.now().toString(),
      'timezone': DateTime.now().timeZoneName,
    }));
    await Hive.box<bool>('premium').put('premium', true);

    Navigator.push(
        context,
        PageTransition<Widget>(
            child: const HomeScreen(), type: PageTransitionType.rightToLeft));
  }
}
