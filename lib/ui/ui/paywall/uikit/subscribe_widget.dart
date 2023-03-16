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
      required this.isSelected,
      required this.header,
      required this.footer,
      this.bestValue})
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
        width: 135.w,
        padding: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isSelected ? AppColors.white : Colors.transparent,
          border: bestValue == true && isSelected
              ? null
              : Border.all(color: AppColors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              header,
              style: AppTypography.mainStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.black : AppColors.white,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$$price',
                  style: AppTypography.mainStyle.copyWith(
                    fontSize: 28.sp,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? AppColors.purple : AppColors.white,
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: footer,
                      style: AppTypography.mainStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: isSelected ? AppColors.black : AppColors.white,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            bestValue == true && isSelected
                ? Container(
                    width: 116.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      color: AppColors.black,
                    ),
                    child: Center(
                      child: Text(
                        applocale.best,
                        style: AppTypography.mainStyle.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 11.5.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 16.h,
                  )
          ],
        ),
      ),
    );
  }
}
