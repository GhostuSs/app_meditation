import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';

abstract class AppTypography{
  static const String _fontfamily = 'Inter';
  static const TextStyle mainStyle = TextStyle(
    fontFamily: _fontfamily,
    color: AppColors.white,

  );
}