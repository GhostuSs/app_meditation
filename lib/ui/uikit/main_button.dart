import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Type { main, additional }

class MainButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Type? type;
  final double? width;
  final String label;
  const MainButton({
    Key? key,
    this.onTap,
    this.type,
    this.width,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        height: 48.h,
        width: width ?? 100.w,
        decoration: BoxDecoration(
          color: type == Type.main ? AppColors.orange : AppColors.white,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
