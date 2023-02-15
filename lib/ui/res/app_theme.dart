import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme{
  static ThemeData mainTheme = ThemeData(
    primarySwatch: MaterialColor(
      0xFF6357DB,
      <int, Color>{
        50: AppColors.purple.withOpacity(0.1), 
        100: AppColors.purple.withOpacity(0.2),
        200: AppColors.purple.withOpacity(0.3),
        300: AppColors.purple.withOpacity(0.4),
        400: AppColors.purple.withOpacity(0.5),
        500: AppColors.purple.withOpacity(0.6),
        600: AppColors.purple.withOpacity(0.7),
        700: AppColors.purple.withOpacity(0.8),
        800: AppColors.purple.withOpacity(0.9),
        900: AppColors.purple,
      },
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: AppColors.purple,
      hintStyle: AppTypography.mainStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18.w,
          color: AppColors.black.withOpacity(0.2)
      ),
      labelStyle: AppTypography.mainStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18.w,
          color: AppColors.darkGray
      ),
    )
  );
}