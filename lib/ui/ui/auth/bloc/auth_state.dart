part of 'auth_cubit.dart';

class AuthState {
  AuthState({this.correct});

  final bool? correct;

  AuthState copyWith({
    bool? correct,
  }) {
    return AuthState(correct: correct ?? this.correct);
  }
}
