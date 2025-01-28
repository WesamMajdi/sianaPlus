import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/profile/profile_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/profile/profile_repository.dart';

class FetchProfileUseCase {
  final ProfileRepository repository;

  FetchProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getUserProfile();
  }
}
