import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/sensor_entity.dart';
import '../repositories/sensor_repository.dart';


class GetSensorsUseCase {
  final SensorRepository _repository;

  GetSensorsUseCase(this._repository);

  Future<Either<Failure, List<SensorEntity>>> call() {
    return _repository.getSensors();
  }
}
