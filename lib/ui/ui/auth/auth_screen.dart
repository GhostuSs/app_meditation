import 'package:app_meditation/domain/urls/url.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:app_meditation/ui/uikit/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context){
    final applocale = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.purple,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              const BgDecoration(),
              Padding(
                padding: EdgeInsets.only(left: 22.w,right:22.w,top: 40.h),
                child: Column(
                  children: [
                    RichText(
                      textAlign:TextAlign.center,
                      text: TextSpan(
                          text: applocale.authHeader,
                        style: AppTypography.mainStyle.copyWith(
                          fontSize: 38.w,
                          fontWeight: FontWeight.w800,
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18.h,bottom: 30.h),
                      child: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints.expand(width: 22.w,height: 22.w,),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.white,
                            ),
                            child: Center(
                              child: Icon(Icons.check,color: AppColors.purple,size: 15.w,),
                            ),
                          ),
                          const SizedBox(width: 9,),
                          RichText(text: TextSpan(
                              text: applocale.agreeWith,
                              style: AppTypography.mainStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.w,
                                color: AppColors.white,
                              ),
                              children: [
                                WidgetSpan(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: InkWell(child: Text(
                                    applocale.termsAndConditions,style: AppTypography.mainStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.w,
                                    color: AppColors.black,
                                  ),
                                  ),onTap: ()=>launchUrlString(BaseUrls.terms),),
                                ),),
                                TextSpan(
                                  text: applocale.and,
                                  style: AppTypography.mainStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.w,
                                    color: AppColors.white,
                                  ),
                                ),
                                WidgetSpan(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: InkWell(child: Text(
                                    applocale.privacy,style: AppTypography.mainStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.w,
                                    color: AppColors.black,
                                  ),
                                  ),onTap: ()=>launchUrlString(BaseUrls.privacyPolicy),),
                                ),),
                              ]
                          ),
                          ),
                        ],
                      ),
                    ),
                    MainButton(
                      label: applocale.continu,
                      onTap: (){},
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        text:applocale.haveAcc,
                          style: AppTypography.mainStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.w,
                            color: AppColors.white,
                          ),
                        children: [
                          TextSpan(
                            text: applocale.signIn,
                            style: AppTypography.mainStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.w,
                              color: AppColors.black,
                            ),
                          )
                        ]
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
