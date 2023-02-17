import 'package:app_meditation/generated/assets.dart';
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
import 'package:page_transition/page_transition.dart';

class PayWallScreen extends StatefulWidget {
  const PayWallScreen({Key? key}) : super(key: key);

  @override
  State<PayWallScreen> createState() => _PayWallScreenState();
}

class _PayWallScreenState extends State<PayWallScreen> {
  int selected=0;
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
            minimum: EdgeInsets.symmetric(horizontal: 19.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    InkWell(
                      child: Icon(
                        Icons.clear,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(Assets.imagesPaywall),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  applocale.trySoulmates,
                  textAlign: TextAlign.center,
                  style: AppTypography.mainStyle.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 32.w,
                      color: AppColors.white),
                ),
                const SizedBox(
                  height: 10,
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
                        fontSize: 16.w,
                      ),
                    )
                  ],
                ),
                SizedBox(height:10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SubscribeWidget(onTap: selected!=0 ? ()=>setState(()=>selected=0) : (){}, price: '39.99', isSelected: selected==0, header: applocale.annual, footer: '\$3.99 ${applocale.perMonth}',bestValue: true,),
                    SizedBox(width: 24.w,),
                    SubscribeWidget(onTap: selected!=1 ? ()=>setState(()=>selected=1) : (){}, price: '4.99', isSelected: selected==1,header: applocale.monthly,footer: applocale.perMonth,)

                  ],
                ),
                SizedBox(height: 10.h,),
                MainButton(label: applocale.tryForFreeAndSubscribe,onTap: navigateToMain,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToMain(){
    Navigator.push(context, PageTransition<Widget>(child: const HomeScreen(), type: PageTransitionType.rightToLeft));
  }
}
