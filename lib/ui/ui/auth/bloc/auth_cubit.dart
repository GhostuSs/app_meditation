import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/ui/ui/reasons/reason_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:regexed_validator/regexed_validator.dart' as validator;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(correct: false));

  void navigateToReason(
      {required BuildContext context,
      required String name,
      required String phone,
      required String mail}) {
    Hive.box<UserData>('user')
        .put('user', UserData(name: name, phone: phone, mail: mail));
    Navigator.push<Widget>(
      context,
      PageTransition(
        child: const ReasonScreen(),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  void check(
      {required String phone, required String mail, required String name}) {
    if (name.isNotEmpty &&
        mail.isNotEmpty &&
        phone.isNotEmpty &&
        phone.length == 15 &&
        validator.validator.email(mail)) {
      // FocusManager.instance.primaryFocus?.unfocus();
      emit(state.copyWith(correct: true));
    } else {
      if (state.correct == true) emit(state.copyWith(correct: false));
    }
  }
}
