import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.onTap,
    this.width,
    this.isActive,
    required this.label,
  }) : super(key: key);
  final bool? isActive;
  final VoidCallback? onTap;
  final double? width;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive != true && isActive != null ? null : onTap,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        height: 53.h,
        width: width,
        decoration: BoxDecoration(
          color: isActive != null
              ? isActive == true
                  ? AppColors.black
                  : AppColors.darkGray.withOpacity(0.8)
              : AppColors.black,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.mainStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isActive != null
                    ? isActive == true
                        ? AppColors.white
                        : AppColors.white.withOpacity(0.8)
                    : AppColors.white),
          ),
        ),
      ),
    );
  }
}
