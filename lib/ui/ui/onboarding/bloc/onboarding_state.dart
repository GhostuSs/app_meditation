part of 'onboarding_cubit.dart';

class OnboardingState {
  OnboardingState({this.currInd});

  final int? currInd;

  OnboardingState copyWith({
    int? newCurrInd,
  }) {
    return OnboardingState(
      currInd: newCurrInd ?? currInd,
    );
  }
}
