import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/notifications/notifications_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/profile/user_profile_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/data/repositories/notifications/notifications_repository_impl..dart';
import 'package:maintenance_app/src/features/client%20app/data/repositories/orders/orders_repository_impl.dart';
import 'package:maintenance_app/src/features/client%20app/data/repositories/product/product_repository_impl.dart';
import 'package:maintenance_app/src/features/client%20app/data/repositories/profile/user_profile_repository_impl.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/notifications/notifications_repository.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/notifications/fetch_notifications_useCase.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/product/fetch_product_useCase.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/notification_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/data_sources/delivery_maintenance_data_source.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/repositories/delivery_maintenance_repository_impl.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/repositories/delivery_maintenance.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/usecases/fetch_delivery_maintenance.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/data_sources/delivery_shop_data_source.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/repositories/delivery_shop_repository_impl.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/repositories/delivery_shop.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/usecases/fetch_delivery_shop.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/maintenance_parts_hand_receipt/maintenance_parts_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/maintenance_parts_online/maintenance_parts_online_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/recovered_maintenance_parts/recovered_maintenance_parts_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/repositories/maintenance_parts_hand_receipt/maintenance_parts_repository_impl.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/repositories/maintenance_parts_online/maintenance_parts_repository_impl.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/repositories/recovered_maintenance_parts/recovered_maintenance_parts_repository_impl.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/hand_receipt_maintenance_parts/maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/online_maintenance_parts/online_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/recovered_maintenance_parts/recovered_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/hand_receipt_maintenance_parts/fetch_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/online_maintenance_parts/fetch_online_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/recovered_maintenance_parts/fetch_recovered_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/hand_receipt_maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/profile/profile_repository.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/profile/fetch_profile_useCase.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/online_maintenance_parts/online_maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/recovered_maintenance_parts/recovered_maintenance_parts_cubit.dart';

import '../../features/client app/data/data_sources/category/category_data_source.dart';
import '../../features/client app/data/data_sources/orders/orders_data_source.dart';
import '../../features/client app/data/data_sources/product/product_data_source.dart';
import '../../features/client app/data/repositories/category/category_repository_impl.dart';
import '../../features/client app/domain/repositories/category/category_repository.dart';
import '../../features/client app/domain/repositories/orders/orders_repository.dart';
import '../../features/client app/domain/usecases/category/fetch_categories_useCase.dart';
import '../../features/client app/domain/usecases/orders/fetch_orders_useCase.dart';
import '../../features/client app/presentation/controller/cubits/category_cubit.dart';
import '../../features/client app/presentation/controller/cubits/order_cubit.dart';
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
  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(getIt(), getIt()));
  getIt.registerFactory<OrderCubit>(() => OrderCubit(getIt()));
  getIt.registerFactory<HandReceiptCubit>(() => HandReceiptCubit(getIt()));
  getIt.registerFactory<ReturnHandReceiptCubit>(
      () => ReturnHandReceiptCubit(getIt()));
  getIt.registerFactory<NotificationCubit>(() => NotificationCubit(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerFactory<DeliveryShopCubit>(() => DeliveryShopCubit(getIt()));
  getIt.registerFactory<DeliveryMaintenanceCubit>(
      () => DeliveryMaintenanceCubit(getIt()));
  getIt.registerFactory<OnlineCubit>(() => OnlineCubit(getIt()));
}

void _initUseCases() {
  getIt.registerLazySingleton<CategoriesUseCase>(
    () => CategoriesUseCase(getIt()),
  );
  getIt.registerLazySingleton<ProductsUseCase>(
    () => ProductsUseCase(getIt()),
  );
  getIt.registerLazySingleton<OrderUseCase>(
    () => OrderUseCase(getIt()),
  );
  getIt.registerLazySingleton<HandReceiptUseCase>(
    () => HandReceiptUseCase(getIt()),
  );
  getIt.registerLazySingleton<ReturnHandReceiptUseCases>(
    () => ReturnHandReceiptUseCases(getIt()),
  );
  getIt.registerLazySingleton<NotificationUseCase>(
    () => NotificationUseCase(getIt()),
  );
  getIt.registerLazySingleton<FetchProfileUseCase>(
    () => FetchProfileUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeliveryShopUseCase>(
    () => DeliveryShopUseCase(getIt()),
  );
  getIt.registerLazySingleton<OnlineUseCase>(
    () => OnlineUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeliveryMaintenanceUseCase>(
    () => DeliveryMaintenanceUseCase(getIt()),
  );
}

void _initDataSources() {
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
  getIt.registerLazySingleton<HandReceiptRemoteDataSource>(
    () => HandReceiptRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<NotificationsDataSource>(
    () => NotificationsDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
  getIt.registerLazySingleton<ReturnHandReceiptRemoteDataSource>(
    () => ReturnHandReceiptRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
  getIt.registerLazySingleton<DeliveryShopRemoteDataSource>(
    () => DeliveryShopRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<DeliveryMaintenanceRemoteDataSource>(
    () => DeliveryMaintenanceRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
  getIt.registerLazySingleton<OnlineRemoteDataSource>(
    () => OnlineRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
}

void _initRepositories() {
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<HandReceiptRepository>(
    () => HandReceiptRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerFactory<ReturnHandReceiptRepository>(
      () => ReturnHandReceiptRepositoryImpl(remoteDataSource: getIt()));

  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => UserProfileRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<DeliveryShopRepository>(
    () => DeliveryShopRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<DeliveryMaintenanceRepository>(
    () => DeliveryMaintenanceRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<OnlineRepository>(
    () => OnlineRepositoryImpl(
      getIt(),
    ),
  );
}

Future<void> _initExternalDependencies() async {
  getIt.registerLazySingleton(() => ApiController());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
