import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginModel createLoginRequest);
  Future<Either<Failure, UserEntity>> signup(SignupModel createSignupRequest);

  Future<Either<Failure, void>> updatePassword(
      UpdtePasswordModel updatePasswordRequest);

  Future<Either<Failure, void>> updateEmail(
      UpdateEmailModel updateEmailRequest);

  Future<Either<Failure, void>> forgotPassword(
      ForgotPasswordModel forgotPasswordRequest);

  Future<Either<Failure, void>> resetPassword(
      ResetPasswordModel resetPasswordRequest);
}
