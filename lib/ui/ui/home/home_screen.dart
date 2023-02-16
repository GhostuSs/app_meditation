import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/home/uikit/home_button.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final applocale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: Stack(
        children: [
          const BgDecoration(),
          SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hi, ${Hive.box<UserData>('user').values.first.name}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.mainStyle.copyWith(
                          fontSize: 33.w,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 70),
                    child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Invite',
                              style: AppTypography.mainStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.w,
                                  color: AppColors.black),
                            ),
                          ),
                        ),
                        TextSpan(
                            text: ' your partner',
                            style: AppTypography.mainStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                                color: AppColors.white))
                      ]),
                    ),
                  ),
                  HomeButton(
                    meditationName: '',
                    label: applocale.relationshipCouching,
                    iconPath: Assets.imagesPersonCircle,
                  ),
                  HomeButton(
                    meditationName: '',
                    label: applocale.resolveConflicts,
                    iconPath: Assets.imagesHeartDamaged,
                  ),
                  HomeButton(
                    meditationName: '',
                    label: applocale.dateIdeas,
                    iconPath: Assets.imagesFire,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
