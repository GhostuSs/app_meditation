import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscribeWidget extends StatelessWidget {
  const SubscribeWidget(
      {Key? key,
      required this.onTap,
      required this.price,
      required this.isSelected, required this.header, required this.footer, this.bestValue})
      : super(key: key);
  final VoidCallback onTap;
  final String price;
  final String footer;
  final String header;
  final bool? bestValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final applocale = AppLocalizations.of(context)!;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        constraints: BoxConstraints.expand(
          width: 140.w,
          height: 110.h,
        ),
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isSelected ? AppColors.white : Colors.transparent,
          border: bestValue==true&&isSelected ?  null : Border.all(color: AppColors.white),
        ),
        child: Column(
          children: [
            Text(
              header,
              style: AppTypography.mainStyle.copyWith(
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.black : AppColors.white,
              ),
            ),
            Text(
              '\$$price',
              style: AppTypography.mainStyle.copyWith(
                fontSize: 31.w,
                fontWeight: FontWeight.w800,
                color: isSelected ? AppColors.purple :AppColors.white,
              ),
            ),
            Text(
              footer,
              style: AppTypography.mainStyle.copyWith(
                fontSize: 12.w,
                fontWeight: FontWeight.w300,
                color: isSelected ? AppColors.black : AppColors.white,
              ),
            ),
            const Spacer(),
            if(bestValue==true&&isSelected)Container(
              width: 116,
              height: 16.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r),),
                color: AppColors.black,
              ),
              child: Center(
                child: Text(applocale.best,style: AppTypography.mainStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.w,
                  color: AppColors.white,
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
