import 'package:app_meditation/ui/ui/auth/auth_screen.dart';
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

  void navigateToHome({required BuildContext context}) {
    Hive.box<bool>('onbseen').put('onbseen', true);
    Navigator.push<Widget>(
      context,
      PageTransition(
        child: const AuthScreen(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  void prevPage() {
    if ((state.currInd ?? 0) > 0) {
      emit(state.copyWith(newCurrInd: (state.currInd ?? 0) - 1));
    }
  }
}
