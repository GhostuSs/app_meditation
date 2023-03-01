import 'dart:async';

import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/main.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/personalizing/personalizing_screen.dart';
import 'package:app_meditation/ui/ui/reasons/uikit/reason_card.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:app_meditation/ui/uikit/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

class ReasonScreen extends StatefulWidget {
  const ReasonScreen({Key? key}) : super(key: key);

  @override
  State<ReasonScreen> createState() => _ReasonScreenState();
}

class _ReasonScreenState extends State<ReasonScreen> {
  List<String> selected = [];

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
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 40.h,
              ),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: applocale.reasonTitle,
                      style: AppTypography.mainStyle.copyWith(
                        fontSize: 34.w,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReasonCard(
                    label: applocale.completeQuizes,
                    isSelected: selected.contains(applocale.completeQuizes),
                    onTap: () => _selectReason(applocale.completeQuizes),
                    iconType: IconType.quiz,
                  ),
                  ReasonCard(
                    label: applocale.chatAndShare,
                    isSelected: selected.contains(applocale.chatAndShare),
                    onTap: () => _selectReason(applocale.chatAndShare),
                    iconType: IconType.chat,
                  ),
                  ReasonCard(
                    label: applocale.watchRelationship,
                    isSelected: selected.contains(applocale.watchRelationship),
                    onTap: () => _selectReason(applocale.watchRelationship),
                    iconType: IconType.video,
                  ),
                  ReasonCard(
                    label: applocale.trackImportant,
                    isSelected: selected.contains(applocale.trackImportant),
                    onTap: () => _selectReason(applocale.trackImportant),
                    iconType: IconType.calendar,
                  ),
                  ReasonCard(
                    label: applocale.learnToResolve,
                    isSelected: selected.contains(applocale.learnToResolve),
                    onTap: () => _selectReason(applocale.learnToResolve),
                    iconType: IconType.letter,
                  ),
                  ReasonCard(
                    label: applocale.findCoolDate,
                    isSelected: selected.contains(applocale.findCoolDate),
                    onTap: () => _selectReason(applocale.findCoolDate),
                    iconType: IconType.love,
                  ),
                  ReasonCard(
                    label: applocale.createAndShare,
                    isSelected: selected.contains(applocale.createAndShare),
                    onTap: () => _selectReason(applocale.createAndShare),
                    iconType: IconType.time,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (selected.isNotEmpty)
                    MainButton(
                      label: applocale.continu,
                      onTap: () async {
                        final UserData user =
                            Hive.box<UserData>('user').values.first;
                        user.choose = selected;
                        await Hive.box<UserData>('user').put('user', user);
                        unawaited(analytics.logEvent('personalizings_chosen',
                            eventProperties: <String, dynamic>{
                              'timezone': DateTime.now().timeZoneName,
                              'date': DateTime.now().toString(),
                              'personalizings': selected
                            }));
                        Navigator.push(
                          context,
                          PageTransition<Widget>(
                            child: const PersonalizingScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _selectReason(String reason) {
    setState(() {
      if (selected.contains(reason) == false) {
        selected.add(reason);
      } else {
        selected.remove(reason);
      }
    });
  }
}
