// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:maintenance_app/src/core/constants/constants.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit(this.authUseCase) : super(AuthState());

  void login(LoginModel createLoginRequest) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.login(createLoginRequest);

      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (user) async {
          final prefs = await SharedPreferences.getInstance();

          final isFirstTime = prefs.getBool(FIRST_TIME_KEY) ?? true;

          if (isFirstTime) {
            // await authRemoteDataSource.registerDevice();
            await prefs.setBool(FIRST_TIME_KEY, false);
          }

          emit(state.copyWith(status: AuthStatus.success, user: user));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void signup(SignupModel createSignupRequest) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.signup(createSignupRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void updatePassword(UpdtePasswordModel updatePasswordRequest) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.updatePassword(updatePasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            status: AuthStatus.success,
            successMessage: 'تم تغيير كلمة المرور بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void updateEmail(UpdateEmailModel updateEmailRequest) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.updateEmail(updateEmailRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            status: AuthStatus.success,
            successMessage: 'تم تحديث البريد الإلكتروني بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void forgotPassword(ForgotPasswordModel forgotPasswordRequest) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.forgotPassword(forgotPasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(
          status: AuthStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void resetPassword(ResetPasswordModel resetPasswordRequest) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.resetPassword(resetPasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            status: AuthStatus.success,
            successMessage: 'تم استعادة كلمة المرور بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void updatePhone(String phone) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authUseCase.updatePhone(phone);
      result.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            status: AuthStatus.success,
            successMessage: 'تم تعديل رقم الهاتف بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }
}
