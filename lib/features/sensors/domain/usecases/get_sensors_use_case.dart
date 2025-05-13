import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../repositories/sensor_repository.dart';

class GetSensorsUseCase {
  final SensorRepository repository;

  GetSensorsUseCase(this.repository);

  Future<Either<String, List<SensorEntity>>> execute() async {
    try {
      final sensors = await repository.getSensors();
      return Right(sensors);
    } catch (e) {
      return Left('Failed to get sensors: $e');
    }
  }
}
