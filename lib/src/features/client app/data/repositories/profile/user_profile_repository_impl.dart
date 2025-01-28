import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/profile/user_profile_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/profile/profile_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/profile/profile_repository.dart';

class UserProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getUserProfile() async {
    try {
      final result = await remoteDataSource.getUserProfile();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: 'There is an error'));
    }
  }
}
