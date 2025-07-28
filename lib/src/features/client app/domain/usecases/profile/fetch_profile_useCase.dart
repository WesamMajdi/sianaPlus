import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/profile/slider_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/profile/profile_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/profile/profile_repository.dart';

class FetchProfileUseCase {
  final ProfileRepository repository;

  FetchProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getUserProfile();
  }

  Future<Either<Failure, void>> createProblem(String text) {
    return repository.createProblem(text);
  }

  Future<Either<Failure, void>> changeName(String fullName) {
    return repository.changeName(fullName);
  }

  Future<Either<Failure, HomeModel>> getHomePage() async {
    return await repository.getHomePage();
  }
}
