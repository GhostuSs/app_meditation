import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/auth/auth_screen.dart';
import 'package:app_meditation/ui/ui/meditationplayer/meditation_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
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
        padding: EdgeInsets.only(bottom: 14.h),
        child: InkWell(
          onTap: () {
            Navigator.push<Widget>(
              context,
              PageTransition(
                child: Hive.box<UserData>('user').values.first.name==null
                    ? const AuthScreen()
                    : MeditationPlayerScreen(
                        meditationName: meditationName,
                        label: label,
                      ),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 18.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.white),
            ),
            // constraints: BoxConstraints.expand(height: 60.h),
            child: Row(
              children: [
                SvgPicture.asset(iconPath),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 200.w,
                  child: RichText(
                    text: TextSpan(
                      text: label,
                      style: AppTypography.mainStyle.copyWith(
                        fontSize: 16.5.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
