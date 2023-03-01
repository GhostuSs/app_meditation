import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RawTextField extends StatelessWidget {
  const RawTextField({
    Key? key,
    this.filled,
    this.onChanged,
    this.textInputType,
    required this.controller,
    required this.hint,
    required this.icon,
    this.iconHeight,
    // this.mask,
    this.maxLength,
    this.action,
    this.focusNode,
    this.onEditComplete,
  }) : super(key: key);
  final bool? filled;
  final String icon;

  // final MaskTextInputFormatter? mask;
  final VoidCallback? onEditComplete;
  final TextInputAction? action;
  final String hint;
  final FocusNode? focusNode;
  final double? iconHeight;
  final int? maxLength;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        keyboardType: textInputType,
        textInputAction: action,
        // inputFormatters: [if (mask != null) mask!],
        style: AppTypography.mainStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18.w,
            color: filled == true ? AppColors.black : AppColors.white),
        maxLength: maxLength,
        onEditingComplete: onEditComplete,
        decoration: InputDecoration(
          filled: filled ?? false,
          hintText: hint,
          hintStyle: AppTypography.mainStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.w,
              color: filled == true
                  ? AppColors.black.withOpacity(0.2)
                  : AppColors.white.withOpacity(0.4)),
          prefixIconColor: filled == true ? AppColors.purple : AppColors.white,
          prefixIcon: SvgPicture.asset(icon),
          prefixIconConstraints:
              BoxConstraints.expand(width: 40.w, height: iconHeight ?? 18.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColors.white),
          ),
          fillColor: filled == true ? AppColors.white : Colors.transparent,
        ),
      );
}
