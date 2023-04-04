import 'dart:ui' as ui;
import 'package:app_meditation/domain/urls/url.dart';
import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/home/uikit/home_button.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
            bottom: false,
            minimum: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              children: [
                Text(
                  'Hi${Hive.box<UserData>('user').values.first.name?.isNotEmpty == true ? ", ${Hive.box<UserData>('user').values.first.name}" : ''}',
                  overflow: TextOverflow.clip,
                  style: AppTypography.mainStyle.copyWith(
                    fontSize: 33.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Invite',
                        style: AppTypography.mainStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showDialog<Widget>(
                                context: context,
                                builder: (context) => BackdropFilter(
                                  filter:
                                      ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 35),
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
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 24.h,
                                                  color: AppColors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 28.w,
                                              vertical: 38.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.r,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Sharing',
                                                  style: AppTypography.mainStyle
                                                      .copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 34.sp,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 30,
                                                    bottom: 20,
                                                  ),
                                                  child: Text(
                                                    'Share this link to your partner\nto pair your accounts:',
                                                    textAlign: TextAlign.center,
                                                    style: AppTypography
                                                        .mainStyle
                                                        .copyWith(
                                                      fontSize: 16.sp,
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
                                                          content: Text(
                                                            'link was coppied to clipboard',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp,
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              AppColors.darkGray
                                                                  .withOpacity(
                                                            0.5,
                                                          ),
                                                          duration:
                                                              const Duration(
                                                            seconds: 3,
                                                          ),
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
                                                      fontSize: 14.sp,
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
                                  ),
                                ),
                              ),
                      ),
                      TextSpan(
                        text: ' your partner',
                        style: AppTypography.mainStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
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
                      HomeButton(
                        meditationName: 'couplestherapy',
                        label: applocale.couplesTherapy,
                        iconPath: Assets.imagesHeartDamaged,
                      ),
                      HomeButton(
                        meditationName: 'couplegames',
                        label: applocale.coupleGames,
                        iconPath: Assets.imagesFire,
                      ),
                      HomeButton(
                        meditationName: 'improveattr',
                        label: applocale.improveAttrInCouple,
                        iconPath: Assets.imagesPersonCircle,
                      ),
                      HomeButton(
                        meditationName: 'howtocreateandsavmemories',
                        label: applocale.howToCrAndSv,
                        iconPath: Assets.imagesPersonCircle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 100.h),
                        child: InkWell(
                          onTap: () => _showDeleteDialog(context, applocale),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: applocale.deleteMyAcc,
                                style: AppTypography.mainStyle.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAcc(BuildContext context) async {
    Navigator.pop(context);
    // await Hive.box<UserData>('user').clear();
    // await Hive.box<UserData>('user').put(
    //   'user',
    //   UserData(
    //     name: '',
    //   ),
    // );
    await showCupertinoDialog<void>(
      context: context,
      builder: (w) => CupertinoAlertDialog(
        title: const Text(
            'Thank you, your account will be deleted in 48 hours. You can use our features meanwhile.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Continue',
              style: AppTypography.mainStyle
                  .copyWith(fontSize: 16.sp, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, AppLocalizations applocale) {
    showCupertinoModalPopup<void>(
      builder: (widget) => CupertinoActionSheet(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Confirm deleting you account and all your personal data?',
              style: AppTypography.mainStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.darkGray)),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => _deleteAcc(context),
            child: Text(
              applocale.confirm,
              style: AppTypography.mainStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGray.withOpacity(0.5),
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              applocale.back,
              style: AppTypography.mainStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.purple,
              ),
            ),
          ),
        ],
      ),
      context: context,
    );
  }
}
