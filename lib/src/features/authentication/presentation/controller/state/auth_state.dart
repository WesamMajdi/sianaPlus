import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';

enum LoginStatus { initial, loading, success, failure }

enum VerificationStatus { initial, loading, success, failure }

enum SignUpStatus { initial, loading, success, failure }

enum ForgotPasswordStatus { initial, loading, success, failure }

enum ResetPasswordStatus { initial, loading, success, failure }

enum UpdateEmailStatus { initial, loading, success, failure }

enum UpdatePasswordStatus { initial, loading, success, failure }

enum UpdatePhoneStatus { initial, loading, success, failure }

enum PhoneVerifyStatus { initial, loading, success, failure }

enum SendVerificationCode2Status { initial, loading, success, failure }

class AuthState extends Equatable {
  final LoginStatus loginStatus;
  final SendVerificationCode2Status sendVerificationCode2Status;
  final SignUpStatus signUpStatus;
  final PhoneVerifyStatus phoneVerifyStatus;
  final String? phoneVerifyMessage;
  final ForgotPasswordStatus forgotPasswordStatus;
  final ResetPasswordStatus resetPasswordStatus;
  final UpdateEmailStatus updateEmailStatus;
  final UpdatePasswordStatus updatePasswordStatus;
  final UpdatePhoneStatus updatePhone;
  final VerificationStatus verificationStatus;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;
  final String? phone;

  final SignupResponseData? userSignup;

  const AuthState(
      {this.loginStatus = LoginStatus.initial,
      this.signUpStatus = SignUpStatus.initial,
      this.sendVerificationCode2Status = SendVerificationCode2Status.initial,
      this.forgotPasswordStatus = ForgotPasswordStatus.initial,
      this.resetPasswordStatus = ResetPasswordStatus.initial,
      this.updateEmailStatus = UpdateEmailStatus.initial,
      this.updatePasswordStatus = UpdatePasswordStatus.initial,
      this.verificationStatus = VerificationStatus.initial,
      this.updatePhone = UpdatePhoneStatus.initial,
      this.phoneVerifyStatus = PhoneVerifyStatus.initial,
      this.phoneVerifyMessage,
      this.errorMessage,
      this.user,
      this.phone,
      this.successMessage,
      this.userSignup});

  factory AuthState.initial() {
    return const AuthState(
      loginStatus: LoginStatus.initial,
      signUpStatus: SignUpStatus.initial,
      sendVerificationCode2Status: SendVerificationCode2Status.initial,
      forgotPasswordStatus: ForgotPasswordStatus.initial,
      resetPasswordStatus: ResetPasswordStatus.initial,
      updateEmailStatus: UpdateEmailStatus.initial,
      updatePasswordStatus: UpdatePasswordStatus.initial,
      verificationStatus: VerificationStatus.initial,
      updatePhone: UpdatePhoneStatus.initial,
      phoneVerifyStatus: PhoneVerifyStatus.initial,
      errorMessage: '',
      successMessage: '',
      userSignup: null,
      user: null,
      phone: '',
    );
  }

  AuthState copyWith({
    LoginStatus? status,
    SignUpStatus? signUpStatus,
    PhoneVerifyStatus? phoneVerifyStatus,
    String? phoneVerifyMessage,
    ForgotPasswordStatus? forgotPasswordStatus,
    ResetPasswordStatus? resetPasswordStatus,
    UpdateEmailStatus? updateEmailStatus,
    UpdatePasswordStatus? updatePasswordStatus,
    SendVerificationCode2Status? sendVerificationCode2Status,
    UpdatePhoneStatus? updatePhone,
    String? errorMessage,
    String? successMessage,
    String? phone,
    VerificationStatus? verificationStatus,
    UserEntity? user,
    SignupResponseData? userSignup,
  }) {
    return AuthState(
        loginStatus: status ?? this.loginStatus,
        signUpStatus: signUpStatus ?? this.signUpStatus,
        forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
        resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
        updateEmailStatus: updateEmailStatus ?? this.updateEmailStatus,
        updatePasswordStatus: updatePasswordStatus ?? this.updatePasswordStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        userSignup: userSignup ?? this.userSignup,
        phone: phone ?? this.phone,
        updatePhone: updatePhone ?? this.updatePhone,
        phoneVerifyStatus: phoneVerifyStatus ?? this.phoneVerifyStatus,
        phoneVerifyMessage: phoneVerifyMessage ?? this.phoneVerifyMessage,
        sendVerificationCode2Status:
            sendVerificationCode2Status ?? this.sendVerificationCode2Status);
  }

  @override
  List<Object?> get props => [
        loginStatus,
        signUpStatus,
        forgotPasswordStatus,
        resetPasswordStatus,
        updateEmailStatus,
        updatePasswordStatus,
        errorMessage,
        successMessage,
        user,
        verificationStatus,
        userSignup,
        phone,
        updatePhone,
        phoneVerifyStatus,
        phoneVerifyMessage,
        sendVerificationCode2Status
      ];
}
