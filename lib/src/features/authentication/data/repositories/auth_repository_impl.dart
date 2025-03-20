import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/features/authentication/data/data_source/auth_data_source.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';
import 'package:maintenance_app/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> login(
      LoginModel createLoginRequest) async {
    try {
      final response = await remoteDataSource.login(createLoginRequest);
      return Right(response.data!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signup(
      SignupModel createSignupRequest) async {
    try {
      final response = await remoteDataSource.signup(createSignupRequest);
      return Right(response.data!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword(
      UpdtePasswordModel updatePasswordRequest) async {
    try {
      await remoteDataSource.updatePassword(updatePasswordRequest);
      return const Right(null);
    } catch (e) {
      debugPrint('Error in updatePassword: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmail(
      UpdateEmailModel updateEmailRequest) async {
    try {
      await remoteDataSource.updateEmail(updateEmailRequest);
      return const Right(null);
    } catch (e) {
      debugPrint('Error in updateEmail: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(
      ForgotPasswordModel forgotPasswordRequest) async {
    try {
      await remoteDataSource.forgotPassword(forgotPasswordRequest);
      return const Right(null);
    } catch (e) {
      debugPrint('Error in updateEmail: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      ResetPasswordModel resetPasswordRequest) async {
    try {
      await remoteDataSource.resetPassword(resetPasswordRequest);
      return const Right(null);
    } catch (e) {
      debugPrint('Error in updateEmail: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
