import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InfoText extends StatelessWidget {
  const InfoText({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 9.h),
        child: Row(
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
                  fontSize: 13.w,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
            )
          ],
        ),
      );
}
