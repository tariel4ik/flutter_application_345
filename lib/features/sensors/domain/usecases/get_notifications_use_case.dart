import 'package:flutter_application_345/features/sensors/domain/entities/notification_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/repositories/sensor_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

class GetNotificationsUseCase {
  final SensorRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<Either<Failure, List<NotificationEntity>>> call({DateTime? since}) {
    return _repository.getNotifications(since: since);
  }
}
