import 'dart:async';

import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/main.dart';
import 'package:app_meditation/ui/ui/reasons/reason_screen.dart';
// import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:regexed_validator/regexed_validator.dart' as validator;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(correct: false));

  Future<void> navigateToReason(
      {required BuildContext context,
      required String name,
      required String phone,
      required String mail}) async {
    final user = Hive.box<UserData>('user').values.first;
    user.authcompleted = true;
    user.name = name;
    user.phone=phone;
    user.mail=mail;
    await Hive.box<UserData>('user')
        .put('user', user);
    unawaited(analytics.logEvent('user_registered',eventProperties: <String,dynamic>{
      'name':name,
      'phone':phone,
      'mail':mail,
      'date_of_signup':DateTime.now().toString(),
      'timezone':DateTime.now().timeZoneName
    }));

    await Navigator.push<Widget>(
      context,
      PageTransition(
        child: const ReasonScreen(),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  void switcher() {
    emit(state.copyWith(checkPressed: !(state.checkPressed ?? false)));
  }

  void check(
      {required String phone, required String mail, required String name}) {
    if (name.isNotEmpty &&
        mail.isNotEmpty &&
        state.checkPressed == true &&
        phone.isNotEmpty &&
        validator.validator.email(mail)) {
      emit(state.copyWith(correct: true));
    } else {
      if (state.correct == true) emit(state.copyWith(correct: false));
    }
  }
}
