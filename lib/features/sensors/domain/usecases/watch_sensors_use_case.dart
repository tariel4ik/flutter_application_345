import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/sensor_entity.dart';
import '../repositories/sensor_repository.dart';


class WatchSensorsUseCase {
  final SensorRepository _repository;
  final Duration interval;

  WatchSensorsUseCase(
    this._repository, {
    this.interval = const Duration(seconds: 10),
  });

  Stream<Either<Failure, List<SensorEntity>>> call() {
    return _repository.watchSensors();
  }
}
