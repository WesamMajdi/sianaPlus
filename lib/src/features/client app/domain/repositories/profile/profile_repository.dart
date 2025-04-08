// profile_repository.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/profile/profile_entity.dart';

import '../../../../../core/error/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getUserProfile();
  Future<Either<Failure, void>> createProblem(String text);
}
