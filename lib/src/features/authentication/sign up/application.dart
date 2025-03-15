import 'package:flutter_bloc/flutter_bloc.dart';
import 'data.dart';
import 'domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final ApiSignUpService apiService;

  SignUpCubit(this.apiService) : super(SignUpInitial());

  Future<void> signUp(String fullName, String email, String password,
      String confirmPassword, String phoneNumber, String countryCode) async {
    try {
      emit(SginUpLoading());

      final sginUpResponse = await apiService.signUp(
          fullName, email, password, confirmPassword, phoneNumber, countryCode);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', sginUpResponse.data.token);

      emit(SginUpSuccess(sginUpResponse));
    } catch (e) {
      emit(SginUpFailure(e.toString()));
    }
  }
}

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SginUpLoading extends SignUpState {}

class SginUpSuccess extends SignUpState {
  final SignUpResponse signUpResponse;
  SginUpSuccess(this.signUpResponse);
}

class SginUpFailure extends SignUpState {
  final String error;
  SginUpFailure(this.error);
}
