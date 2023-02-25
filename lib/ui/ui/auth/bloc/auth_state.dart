part of 'auth_cubit.dart';

class AuthState {
  AuthState({this.correct, this.checkPressed = true});

  final bool? correct;
  bool? checkPressed = true;

  AuthState copyWith({
    bool? correct,
    bool? checkPressed,
  }) {
    return AuthState(
        correct: correct ?? this.correct,
        checkPressed: checkPressed ?? this.checkPressed);
  }
}
