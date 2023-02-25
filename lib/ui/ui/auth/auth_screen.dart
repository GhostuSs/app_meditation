import 'package:app_meditation/domain/urls/url.dart';
import 'package:app_meditation/generated/assets.dart';
import 'package:app_meditation/ui/res/app_typography.dart';
import 'package:app_meditation/ui/res/color.dart';
import 'package:app_meditation/ui/ui/auth/bloc/auth_cubit.dart';
import 'package:app_meditation/ui/ui/auth/uikit/textfield.dart';
import 'package:app_meditation/ui/uikit/bg_decoration.dart';
import 'package:app_meditation/ui/uikit/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  final AuthCubit cubit = AuthCubit();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final applocale = AppLocalizations.of(context)!;
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: cubit,
      builder: (ctx, state) =>
          Scaffold(
        backgroundColor: AppColors.purple,
        resizeToAvoidBottomInset: false,
        body: KeyboardActions(
          config: _buildConfig(context),
          child: SingleChildScrollView(
            child: Container(
              height: 844,
              child: SafeArea(
                top: false,
                child:  Stack(
                  children: [
                    // const BgDecoration(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 22.w, right: 22.w, top: 40.h, bottom: 20.h),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: applocale.authHeader,
                              style: AppTypography.mainStyle.copyWith(
                                fontSize: 38.w,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.h, bottom: 18.h),
                            child: RawTextField(
                              controller: nameController,
                              filled: true,
                              hint: 'name',
                              icon: Assets.imagesPerson,
                              onChanged: (s) => cubit.check(
                                  phone: phoneController.text,
                                  mail: mailController.text,
                                  name: nameController.text),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 18.h),
                            child: RawTextField(
                              controller: mailController,
                              filled: true,
                              hint: 'e-mail',
                              textInputType: TextInputType.emailAddress,
                              icon: Assets.imagesMail,
                              onChanged: (s) => cubit.check(
                                  phone: phoneController.text,
                                  mail: mailController.text,
                                  name: nameController.text),
                              iconHeight: 14.h,
                            ),
                          ),
                          RawTextField(
                            controller: phoneController,
                            hint: 'phone',
                            icon: Assets.imagesPhone,
                            focusNode: _focusNode,
                            action: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            onChanged: (s) {
                              cubit.check(
                                  phone: phoneController.text,
                                  mail: mailController.text,
                                  name: nameController.text);
                            },),
                          Padding(
                            padding: EdgeInsets.only(top: 18.h, bottom: 30.h),
                            child: Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints.expand(
                                    width: 22.w,
                                    height: 22.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Checkbox(
                                    value: state.checkPressed ?? true,
                                    onChanged: (val) => cubit.switcher(),
                                    fillColor: MaterialStateProperty.all<Color>(
                                      AppColors.white,
                                    ),
                                    checkColor: AppColors.purple,
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: applocale.agreeWith,
                                      style: AppTypography.mainStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.w,
                                        color: AppColors.white,
                                      ),
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: InkWell(
                                              child: Text(
                                                applocale.termsAndConditions,
                                                style:
                                                AppTypography.mainStyle.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.w,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                              onTap: () =>
                                                  launchUrlString(BaseUrls.terms),
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: applocale.and,
                                          style: AppTypography.mainStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.w,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 3,
                                            ),
                                            child: InkWell(
                                              child: Text(
                                                applocale.privacy,
                                                style:
                                                AppTypography.mainStyle.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.w,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                              onTap: () => launchUrlString(
                                                  BaseUrls.privacyPolicy),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          MainButton(
                            label: applocale.continu,
                            isActive: state.correct == true,
                            onTap: () => cubit.navigateToReason(
                                context: context,
                                name: nameController.text,
                                phone: phoneController.text,
                                mail: mailController.text),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                                text: applocale.haveAcc,
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
                                ]),
                          )
                        ],
                      ),
                    )
                  ],
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        nextFocus: true,
        actions:[
        KeyboardActionsItem(
        focusNode: _focusNode,
        footerBuilder: (_) => const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink()),
    )
        ]
    );
  }
}
