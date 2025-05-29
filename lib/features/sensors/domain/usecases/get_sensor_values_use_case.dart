import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/sensor_value_entity.dart';
import '../repositories/sensor_repository.dart';


class GetSensorValuesUseCase {
  final SensorRepository _repository;

  GetSensorValuesUseCase(this._repository);

  Future<Either<Failure, List<SensorValueEntity>>> call({
    required int sensorId
  }) {
    return _repository.getSensorValues(sensorId: sensorId); 
  }
}