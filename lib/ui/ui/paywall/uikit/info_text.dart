import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InfoText extends StatelessWidget {
  final String label;
  const InfoText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 13.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [SvgPicture.asset(Assets.imagesCheck)],
        ),
        const SizedBox(
          width: 17,
        ),
        Text(
          label,
          style: AppTypography.mainStyle.copyWith(
              fontSize: 14.w,
              fontWeight: FontWeight.w400,
              color: AppColors.white),
        )
      ],
    ),
  );
}