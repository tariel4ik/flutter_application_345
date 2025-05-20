import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/notification_entity.dart';
import '../repositories/sensor_repository.dart';


class WatchNotificationsUseCase {
  final SensorRepository _repository;
  final Duration interval;

  WatchNotificationsUseCase(
    this._repository, {
    this.interval = const Duration(seconds: 10),
  });

  Stream<Either<Failure, List<NotificationEntity>>> call() {
    return _repository.watchNotifications();
  }
}
