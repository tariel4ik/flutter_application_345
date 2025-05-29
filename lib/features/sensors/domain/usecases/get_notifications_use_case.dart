import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/notification_entity.dart';
import '../repositories/sensor_repository.dart';


class GetNotificationsUseCase {
  final SensorRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<Either<Failure, List<NotificationEntity>>> call({
    DateTime? since
  }) {
    return _repository.getNotifications(since: since);
  }
}