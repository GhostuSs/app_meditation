import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BgDecoration extends StatelessWidget {
  const BgDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -30.h,
            left: -50.w,
            child: const _WhiteWidget(),
          ),
          Positioned(
            right: -70.w,
            top: 280.h,
            child: const _WhiteWidget(),
          ),
        ],
      );
}

class _WhiteWidget extends StatelessWidget {
  const _WhiteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: 320.w,
        height: 320.w,
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
          AppColors.white.withOpacity(0.2),
          AppColors.white.withOpacity(0)
        ])),
      );
}
