import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/notifications/notifications_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/notifications/notifications_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../model/notifications/notification_model.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsDataSource remoteDataSource;
  NotificationsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<NotificationModel>>> getNotifications(
      PaginationParams paginationParams) async {
    try {
      final response =
      await remoteDataSource.getNotifications(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}