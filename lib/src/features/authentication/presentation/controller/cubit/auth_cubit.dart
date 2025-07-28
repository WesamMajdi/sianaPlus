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
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final result = await authUseCase.login(createLoginRequest);

      result.fold(
        (failure) => emit(state.copyWith(
            status: LoginStatus.failure, errorMessage: failure.message)),
        (user) async {
          final prefs = await SharedPreferences.getInstance();

          final isFirstTime = prefs.getBool(FIRST_TIME_KEY) ?? true;

          if (isFirstTime) {
            // await authRemoteDataSource.registerDevice();
            await prefs.setBool(FIRST_TIME_KEY, false);
          }

          emit(state.copyWith(status: LoginStatus.success, user: user));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void signupWithPhone(SignupModel createSignupRequest) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.loading));
    try {
      final result = await authUseCase.signupWithPhone(createSignupRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            signUpStatus: SignUpStatus.failure, errorMessage: failure.message)),
        (user) => emit(state.copyWith(
            signUpStatus: SignUpStatus.success, userSignup: user)),
      );
    } catch (e) {
      emit(state.copyWith(
          signUpStatus: SignUpStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void signup(SignupModel createSignupRequest) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.loading));
    try {
      final result = await authUseCase.signup(createSignupRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            signUpStatus: SignUpStatus.failure, errorMessage: failure.message)),
        (user) => emit(
            state.copyWith(signUpStatus: SignUpStatus.success, user: user)),
      );
    } catch (e) {
      emit(state.copyWith(
          signUpStatus: SignUpStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void updatePassword(UpdtePasswordModel updatePasswordRequest) async {
    emit(state.copyWith(updatePasswordStatus: UpdatePasswordStatus.loading));
    try {
      final result = await authUseCase.updatePassword(updatePasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            status: LoginStatus.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            updatePasswordStatus: UpdatePasswordStatus.success,
            successMessage: 'تم تغيير كلمة المرور بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          updatePasswordStatus: UpdatePasswordStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void sendVerificationCode(SignupModel request, String code) async {
    emit(state.copyWith(verificationStatus: VerificationStatus.loading));
    print('Sending verification code: $code for ${request.phoneNumber}');

    try {
      final result = await authUseCase.sendVerificationCode(request, code);
      result.fold(
        (failure) {
          emit(state.copyWith(
            verificationStatus: VerificationStatus.failure,
            errorMessage: 'كود التحقق غير صحيح',
          ));
        },
        (user) {
          emit(state.copyWith(
            verificationStatus: VerificationStatus.success,
            user: user,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        verificationStatus: VerificationStatus.failure,
        errorMessage: 'حدث خطأ تقني، يرجى المحاولة لاحقاً',
      ));
    }
  }

  void updateEmail(UpdateEmailModel updateEmailRequest) async {
    emit(state.copyWith(updateEmailStatus: UpdateEmailStatus.loading));
    try {
      final result = await authUseCase.updateEmail(updateEmailRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            updateEmailStatus: UpdateEmailStatus.failure,
            errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            updateEmailStatus: UpdateEmailStatus.success,
            successMessage: 'تم تحديث البريد الإلكتروني بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          updateEmailStatus: UpdateEmailStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void forgotPassword(ForgotPasswordModel forgotPasswordRequest) async {
    emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.loading));
    try {
      final result = await authUseCase.forgotPassword(forgotPasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            forgotPasswordStatus: ForgotPasswordStatus.failure,
            errorMessage: failure.message)),
        (result) => emit(state.copyWith(
          forgotPasswordStatus: ForgotPasswordStatus.success,
          phone: result,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void resetPassword(ResetPasswordModel resetPasswordRequest) async {
    emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.loading));
    try {
      final result = await authUseCase.resetPassword(resetPasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            resetPasswordStatus: ResetPasswordStatus.failure,
            errorMessage: failure.message)),
        (user) async {
          final prefs = await SharedPreferences.getInstance();

          final isFirstTime = prefs.getBool(FIRST_TIME_KEY) ?? true;

          if (isFirstTime) {
            await prefs.setBool(FIRST_TIME_KEY, false);
          }

          emit(state.copyWith(
              resetPasswordStatus: ResetPasswordStatus.success, user: user));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          resetPasswordStatus: ResetPasswordStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void verifyResetCode(ResetVerifyResetCodeModel resetPasswordRequest) async {
    emit(state.copyWith(verificationStatus: VerificationStatus.loading));
    try {
      final result = await authUseCase.verifyResetCode(resetPasswordRequest);
      result.fold(
        (failure) => emit(state.copyWith(
            verificationStatus: VerificationStatus.failure,
            errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            status: LoginStatus.success,
            successMessage: 'تم استعادة كلمة المرور بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          verificationStatus: VerificationStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void updatePhone(String phone) async {
    emit(state.copyWith(updatePhone: UpdatePhoneStatus.loading));
    try {
      final result = await authUseCase.updatePhone(phone);
      result.fold(
        (failure) => emit(state.copyWith(
            updatePhone: UpdatePhoneStatus.failure,
            errorMessage: failure.message)),
        (_) => emit(state.copyWith(
            updatePhone: UpdatePhoneStatus.success,
            successMessage: 'تم تعديل رقم الهاتف بنجاح')),
      );
    } catch (e) {
      emit(state.copyWith(
          updatePhone: UpdatePhoneStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  void phoneNumberVerify(String phoneNumber, String code) async {
    emit(state.copyWith(phoneVerifyStatus: PhoneVerifyStatus.loading));

    try {
      final response = await authUseCase.phoneNumberVerify(phoneNumber, code);
      response.fold(
        (failure) {
          emit(state.copyWith(
            phoneVerifyStatus: PhoneVerifyStatus.failure,
            errorMessage: failure.message,
          ));
        },
        (successMessage) {
          emit(state.copyWith(
            phoneVerifyStatus: PhoneVerifyStatus.success,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        phoneVerifyStatus: PhoneVerifyStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> sendVerificationCode2(String phone, String code) async {
    emit(state.copyWith(
        sendVerificationCode2Status: SendVerificationCode2Status.loading));

    try {
      final response = await authUseCase.sendVerificationCode2(phone, code);
      response.fold(
        (failure) {
          emit(state.copyWith(
            sendVerificationCode2Status: SendVerificationCode2Status.failure,
            errorMessage: failure.message,
          ));
        },
        (successResponse) {
          emit(state.copyWith(
            sendVerificationCode2Status: SendVerificationCode2Status.success,
            phone: phone,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        sendVerificationCode2Status: SendVerificationCode2Status.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
