import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  void LoginUser({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final User user =
          await AuthRepository().loginUser(email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          'user', [user.username!, user.email!, user.id!, user.role!]);

      emit(const LoginSuccessState('Login Successful'));
    } catch (e) {
      print(e.toString());
      emit(LoginFailedState(e.toString()));
    }
  }

  void SignupUser({
    required String email,
    required String password,
    required String username,
    required String country,
    required String state,
    required String city,
  }) async {
    emit(LoginLoadingState());
    try {
      final User user = await AuthRepository().signupUser(
          email: email,
          password: password,
          username: username,
          country: country,
          state: state,
          city: city);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          'user', [user.name!, user.email!, user.id!, user.role!]);
      emit(const LoginSuccessState('Signup Successful'));
    } catch (e) {
      print(e.toString());
      emit(LoginFailedState(e.toString()));
    }
  }
}
