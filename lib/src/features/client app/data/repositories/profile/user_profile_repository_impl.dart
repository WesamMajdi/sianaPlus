import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/profile/user_profile_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/profile/slider_model.dart';
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

  @override
  Future<Either<Failure, void>> createProblem(String text) async {
    try {
      await remoteDataSource.createProblem(text);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changeName(String fullName) async {
    try {
      await remoteDataSource.changeName(fullName);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHomePage() async {
    try {
      final result = await remoteDataSource.getHomePage();
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: 'حدث خطأ أثناء تحميل الصفحة الرئيسية'));
    }
  }
}
