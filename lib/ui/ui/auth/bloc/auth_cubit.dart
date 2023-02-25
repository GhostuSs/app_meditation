import 'dart:async';

import 'package:app_meditation/domain/user_model/user_model.dart';
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
    await Hive.box<UserData>('user')
        .put('user', UserData(name: name, phone: phone, mail: mail));
    // unawaited(AppMetrica.reportEventWithMap('user authenticated', {
    //   'deviceInfo': await DeviceInformation.deviceIMEINumber,
    //   'action done at': DateTime.now().toString(),
    //   'phone': phone,
    //   'e-mail': mail,
    //   'name': name
    // }));
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
