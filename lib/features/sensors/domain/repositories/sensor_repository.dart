
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/notification_entity.dart';
import '../entities/sensor_entity.dart';


abstract class SensorRepository {
  Future<List<SensorEntity>> getSensors();
  Future<List<SensorValueEntity>> getSensorValues(int sensorId);
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({DateTime? since});
  Stream<Either<Failure, List<NotificationEntity>>> watchNotifications();
}
