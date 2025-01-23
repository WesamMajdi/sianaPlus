import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/constants.dart';
import 'data.dart';
import 'domain.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiLoginService apiService;

  LoginCubit(this.apiService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());

      final loginResponse = await apiService.login(email, password);
      await TokenManager.saveToken(loginResponse.data.token);
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool(FIRST_TIME_KEY) ?? true;

      if (isFirstTime) {
        await apiService.registerDevice();

        await prefs.setBool(FIRST_TIME_KEY, false);
      }

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
  String error;
  LoginFailure(this.error);
}
