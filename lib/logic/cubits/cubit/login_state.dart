part of 'login_cubit.dart';

@immutable
class LoginState {
  const LoginState();
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String message;
  const LoginSuccessState(this.message);
}

class LoginFailedState extends LoginState {
  final String message;
  const LoginFailedState(this.message);
}
