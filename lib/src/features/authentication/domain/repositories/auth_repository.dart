import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/user_model.dart';
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginModel createLoginRequest);

  Future<Either<Failure, SignupResponseData>> signupWithPhone(
      SignupModel createSignupRequest);

  Future<Either<Failure, UserModel>> signup(SignupModel createSignupRequest);

  Future<Either<Failure, void>> updatePassword(
      UpdtePasswordModel updatePasswordRequest);

  Future<Either<Failure, void>> updateEmail(
      UpdateEmailModel updateEmailRequest);

  Future<Either<Failure, String>> forgotPassword(
      ForgotPasswordModel forgotPasswordRequest);

  Future<Either<Failure, void>> updatePhone(String phone);

  Future<Either<Failure, UserEntity>> resetPassword(
      ResetPasswordModel resetPasswordRequest);
  Future<Either<Failure, UserModel>> sendVerificationCode(
      SignupModel request, String verificationCode);
  Future<Either<Failure, void>> verifyResetCode(
      ResetVerifyResetCodeModel resetPasswordRequest);

  Future<Either<Failure, PhoneNumberVerifyModel>> phoneNumberVerify(
    String? countryCode,
    String? phoneNumber,
  );
  Future<Either<Failure, void>> sendVerificationCode2(
      String phoneNumber, String code);
}
