import 'package:flutter_bloc/flutter_bloc.dart';
import 'data.dart';
import 'domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;

  LoginCubit(this.apiService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());

      final loginResponse = await apiService.login(email, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', loginResponse.token);

      emit(LoginSuccess(loginResponse));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  LoginSuccess(this.loginResponse);
}

class LoginFailure extends LoginState {
  String? error = "فشل تسجيل دخول , حاول  مرة اخرى";
  LoginFailure(this.error);
}
