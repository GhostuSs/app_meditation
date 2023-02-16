import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReasonCard extends StatelessWidget {
  const ReasonCard({Key? key, required this.label, required this.isSelected, required this.onTap, required this.iconType}) : super(key: key);
  final String label;
  final bool isSelected;
  final IconType iconType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context)=>Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 8.h),
        constraints: BoxConstraints.expand(height: 50.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: isSelected ? AppColors.white : Colors.transparent,
            border: Border.all(color: AppColors.white)
        ),
        child: Row(
          children: [
            Text(iconSelector(),style: TextStyle(
              fontSize: 26.w,
            ),),
            const SizedBox(width: 10,),
            SizedBox(
              width: 240.w,
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: AppTypography.mainStyle.copyWith(
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
  String iconSelector(){
    switch(iconType){
      case IconType.quiz:return '🔖';
      case IconType.chat:return '💬';
      case IconType.video:return '🎬';
      case IconType.calendar:return '📆';
      case IconType.letter:return '💌';
      case IconType.love:return '💖';
      case IconType.time:return '🕗';
    }
  }
}

enum IconType{
  quiz,
  chat,
  video,
  calendar,
  letter,
  love,
  time,
}
