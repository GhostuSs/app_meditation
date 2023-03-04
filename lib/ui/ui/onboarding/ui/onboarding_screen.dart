import 'dart:io' show Platform;

import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/onboarding/bloc/onboarding_cubit.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:app_meditation/ui/uikit/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final OnboardingCubit cubit = OnboardingCubit();
  final PageController pageController = PageController();
  static const Duration duration = Duration(milliseconds: 300);
  static const Curve curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
        bloc: cubit,
        builder: (context, state) => Scaffold(
              backgroundColor: bgColors[state.currInd ?? 0],
              body: SafeArea(
                bottom: false,
                top: false,
                child: Stack(
                  children: [
                    const BgDecoration(),
                    Column(
                      children: [
                        Expanded(
                            child: PageView.builder(
                          itemCount: pages(context).length,
                          controller: pageController,
                          onPageChanged: (index) {
                            cubit.changePage(index: index);
                            // pageController.jumpToPage(index);
                          },
                          itemBuilder: (_, index) => pages(context)[index],
                        )),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: Platform.isIOS ? 20.h : 10.h),
                        child: MainButton(
                          label: AppLocalizations.of(context)!.continu,
                          onTap: state.currInd == pages(context).length - 1
                              ? () => cubit.navigateToAuth(context: context)
                              : () async {
                                  await pageController.nextPage(
                                    duration: duration,
                                    curve: Curves.linear,
                                  );
                                },
                          width: 320.w,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  static List<Color> bgColors = [
    AppColors.pink,
    AppColors.purple,
    AppColors.mainBlue,
    AppColors.orange,
    AppColors.green
  ];

  List<Widget> pages(BuildContext context)=>[
    Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 25.h),
      child: Column(
        children: [
          Image.asset(
            'assets/images/onb1img.png',
            height: MediaQuery.of(context).size.height/2,
          ),
          Text(
            'Improve your\nrelationship',
            textAlign: TextAlign.center,
            style: AppTypography.mainStyle.copyWith(
              fontSize: 44.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16,),
          Text(
            'Share moments. Be mindful and\nlearn your partner. Be happier\ntogether',
            textAlign: TextAlign.center,
            style: AppTypography.mainStyle.copyWith(
                fontSize: 17.sp, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 40.h),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Play & Learn\nabout your\npartner',
              textAlign: TextAlign.center,
              style: AppTypography.mainStyle.copyWith(
                fontSize: 40.sp,
                fontWeight: FontWeight.w900,
                height: 0.9
              ),
            ),
          ),
          Positioned(
            bottom: -80,
              child: Image.asset(
                'assets/images/onb2img.png',
                height: MediaQuery.of(context).size.height*2/2.5,
                width: MediaQuery.of(context).size.width*0.9,
              ),
          ),
        ],
      ),
    ),
    Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: -10.w,
          top: -10.h,
          child: Image.asset(
            'assets/images/onb3img.png',
            height: MediaQuery.of(context).size.height/1.75,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*0.55,
          child: Text(
            'Improve your\nrelationship.\nBe mindful.',
            textAlign: TextAlign.center,
            style: AppTypography.mainStyle.copyWith(
              fontSize: 40.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
      ],
    ),
    Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(children: [
              Text(
                'Chat &\nhave fun',
                textAlign: TextAlign.center,
                style: AppTypography.mainStyle.copyWith(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w900,
                  height: 0.9
                ),
              ),
              Text(
                'Private enrypted chat. Your data\nis not stored anywhere. Unleash\nyour creativity.',
                textAlign: TextAlign.center,
                style: AppTypography.mainStyle
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w300,),
              ),
            ]),
          ),
          Positioned(
              bottom: 40.h,
              child: Image.asset(
                'assets/images/onb4img.png',
                height: MediaQuery.of(context).size.height/1.65,
              ),),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Image.asset(
            'assets/images/onb5img.png',
            height: MediaQuery.of(context).size.height*0.6,
            // width: MediaQuery.of(context).size.width,
          ),
          Text(
            'Create & save\nmemories',
            textAlign: TextAlign.center,
            style: AppTypography.mainStyle.copyWith(
              fontSize: 38.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    )
  ];
}
