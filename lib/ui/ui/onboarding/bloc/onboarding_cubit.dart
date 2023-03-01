import 'dart:async';

import 'package:app_meditation/domain/user_model/user_model.dart';
import 'package:app_meditation/main.dart';
import 'package:app_meditation/ui/ui/auth/auth_screen.dart';
// import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState(currInd: 0));

  void nextPage() {
    if ((state.currInd ?? 0) < 5) {
      emit(state.copyWith(
        newCurrInd: (state.currInd ?? 0) + 1,
      ));
    }
  }

  void changePage({required int index}) {
    emit(state.copyWith(newCurrInd: index));
  }

  Future<void> navigateToAuth({required BuildContext context}) async {
    await Hive.box<bool>('onbseen').put('onbseen', true);
    final user = Hive.box<UserData>('user').values.first;
    user.onbpassed = true;
    await Hive.box<UserData>('user').put('user', user);
    unawaited(analytics.logEvent('onboarding_passed',
        eventProperties: <String, dynamic>{
          'date': DateTime.now().toString(),
          'timezone': DateTime.now().timeZoneName
        }));
    Navigator.push<Widget>(
      context,
      PageTransition(
        child: const AuthScreen(),
        type: PageTransitionType.fade,
      ),
    );
  }

  void prevPage() {
    if ((state.currInd ?? 0) > 0) {
      emit(state.copyWith(newCurrInd: (state.currInd ?? 0) - 1));
    }
  }
}
