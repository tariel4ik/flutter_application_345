import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/sensor_repository.dart';

class GetSensorValuesUseCase {
  final SensorRepository repository;

  GetSensorValuesUseCase(this.repository);

  Future<Either<String, List<SensorValueEntity>>> execute(int sensorId) async {
    try {
      final sensorValues = await repository.getSensorValues(sensorId);
      return Right(sensorValues);
    } catch (e) {
      return Left('Failed to get sensor values: $e');
    }
  }
}
