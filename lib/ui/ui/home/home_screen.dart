import 'dart:ui' as ui;

import 'package:app_meditation/domain/urls/url.dart';
import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/home/uikit/home_button.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              minimum: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                children: [
                  Text(
                    'Hi, ${Hive.box<UserData>('user').isNotEmpty == true ? Hive.box<UserData>('user').values.first.name : ''}',
                    overflow: TextOverflow.clip,
                    style: AppTypography.mainStyle.copyWith(
                      fontSize: 33.w,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 70),
                    child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => showDialog<Widget>(
                              context: context,
                              builder: (context) => BackdropFilter(
                                  filter:
                                      ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 35.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                child: const Icon(
                                                  Icons.clear,
                                                  color: AppColors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 28.w,
                                                vertical: 38.h),
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.r)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Sharing',
                                                  style: AppTypography.mainStyle
                                                      .copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 34.w,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30, bottom: 20),
                                                  child: Text(
                                                    'Share this link to your partner\nto pair your accounts:',
                                                    textAlign: TextAlign.center,
                                                    style: AppTypography
                                                        .mainStyle
                                                        .copyWith(
                                                      fontSize: 16.w,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    FlutterClipboard.copy(
                                                      BaseUrls.shareLink,
                                                    ).then(
                                                      (value) =>
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                        SnackBar(
                                                          action:
                                                              SnackBarAction(
                                                            label: 'Undo',
                                                            textColor: Colors
                                                                .redAccent,
                                                            onPressed: () =>
                                                                Clipboard
                                                                    .setData(
                                                              const ClipboardData(
                                                                text: '',
                                                              ),
                                                            ),
                                                          ),
                                                          content: const Text(
                                                            'link was coppied to clipboard',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                          backgroundColor:
                                                              AppColors.darkGray
                                                                  .withOpacity(
                                                            0.5,
                                                          ),
                                                          duration:
                                                              const Duration(
                                                                  seconds: 3),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  focusColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  splashColor:
                                                      Colors.transparent,
                                                  child: Text(
                                                    BaseUrls.shareLink,
                                                    textAlign: TextAlign.center,
                                                    style: AppTypography
                                                        .mainStyle
                                                        .copyWith(
                                                      fontSize: 14.w,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.purple,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
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
                    meditationName: 'feelcalm',
                    label: applocale.relationshipCouching,
                    iconPath: Assets.imagesPersonCircle,
                  ),
                  HomeButton(
                    meditationName: 'meditate',
                    label: applocale.resolveConflicts,
                    iconPath: Assets.imagesHeartDamaged,
                  ),
                  HomeButton(
                    meditationName: 'sleepspace',
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
