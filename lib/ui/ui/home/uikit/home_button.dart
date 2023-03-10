import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/meditationplayer/meditation_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
      {Key? key,
      required this.meditationName,
      required this.label,
      required this.iconPath})
      : super(key: key);
  final String meditationName;
  final String label;
  final String iconPath;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: InkWell(
          onTap: () => Navigator.push<Widget>(
            context,
            PageTransition(
              child: MeditationPlayerScreen(
                meditationName: meditationName,
              ),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.white),
            ),
            constraints: BoxConstraints.expand(height: 60.h),
            child: Row(
              children: [
                SvgPicture.asset(iconPath),
                const SizedBox(
                  width: 17,
                ),
                Text(
                  label,
                  style: AppTypography.mainStyle.copyWith(
                    fontSize: 17.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
