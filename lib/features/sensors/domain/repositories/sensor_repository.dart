import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/notification_entity.dart';
import '../entities/sensor_entity.dart';
import '../entities/sensor_value_entity.dart';


abstract class SensorRepository {
  Future<Either<Failure, List<SensorEntity>>> getSensors();
  Future<Either<Failure, List<SensorValueEntity>>> getSensorValues({required int sensorId});
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({DateTime? since});
  Stream<Either<Failure, List<NotificationEntity>>> watchNotifications();
  Stream<Either<Failure, List<SensorEntity>>> watchSensors();
}