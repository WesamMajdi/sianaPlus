
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/client app/data/data_sources/category/category_data_source.dart';
import '../../features/client app/data/repositories/category/category_repository_impl.dart';
import '../../features/client app/domain/repositories/category/category_repository.dart';
import '../../features/client app/domain/usecases/category/fetch_categories_useCase.dart';
import '../../features/client app/presentation/controller/cubits/category_cubit.dart';
import '../network/api_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Cubits
  _initCubits();


  // Use Cases
  _initUseCases();

  // Repositories
  _initRepositories();

  // Data Sources
  _initDataSources();

  // External Dependencies
  await _initExternalDependencies();
}

void _initCubits() {

  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(getIt()));

}


void _initUseCases() {
  getIt.registerLazySingleton<CategoriesUseCase>(
        () => CategoriesUseCase(getIt()),
  );

}

void _initRepositories() {
  getIt.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(
      getIt(),
      ),
  );
}

void _initDataSources() {
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

}

Future<void> _initExternalDependencies() async {
  getIt.registerLazySingleton(() => ApiController());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}