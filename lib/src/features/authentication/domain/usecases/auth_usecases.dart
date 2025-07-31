import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/user_model.dart';
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);
  Future<Either<Failure, UserEntity>> login(LoginModel createLoginRequest) {
    return repository.login(createLoginRequest);
  }

  Future<Either<Failure, SignupResponseData>> signupWithPhone(
      SignupModel model) {
    return repository.signupWithPhone(model);
  }

  Future<Either<Failure, UserModel>> signup(SignupModel createSignupRequest) {
    return repository.signup(createSignupRequest);
  }

  Future<Either<Failure, void>> updatePassword(
      UpdtePasswordModel updatePasswordRequest) {
    return repository.updatePassword(updatePasswordRequest);
  }

  Future<Either<Failure, void>> updateEmail(
      UpdateEmailModel updateEmailRequest) {
    return repository.updateEmail(updateEmailRequest);
  }

  Future<Either<Failure, String>> forgotPassword(
      ForgotPasswordModel forgotPasswordRequest) {
    return repository.forgotPassword(forgotPasswordRequest);
  }

  Future<Either<Failure, UserEntity>> resetPassword(
      ResetPasswordModel resetPasswordRequest) {
    return repository.resetPassword(resetPasswordRequest);
  }

  Future<Either<Failure, void>> verifyResetCode(
      ResetVerifyResetCodeModel resetPasswordRequest) {
    return repository.verifyResetCode(resetPasswordRequest);
  }

  Future<Either<Failure, void>> updatePhone(String phone) {
    return repository.updatePhone(phone);
  }

  Future<Either<Failure, UserEntity>> sendVerificationCode(
      SignupModel request, String verificationCode) {
    return repository.sendVerificationCode(request, verificationCode);
  }

  Future<Either<Failure, void>> phoneNumberVerify(String code, String phone) {
    return repository.phoneNumberVerify(code, phone);
  }

  Future<Either<Failure, void>> sendVerificationCode2(
      String phoneNumber, String verificationCode) {
    return repository.sendVerificationCode2(phoneNumber, verificationCode);
  }
}
