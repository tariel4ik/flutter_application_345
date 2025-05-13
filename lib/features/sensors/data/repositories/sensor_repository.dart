import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/repositories/sensor_repository.dart';
import '../api/sensor_api.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorApi api;

  SensorRepositoryImpl(this.api);

  @override
  Future<List<SensorEntity>> getSensors() async {
    final sensorModels = await api.getSensors();
    return sensorModels
        .map(
          (model) => model.toEntity()
        )
        .toList();
  }

  @override
  Future<List<SensorValueEntity>> getSensorValues(int sensorId) async {
    final valueModels = await api.getSensorValues(sensorId);
    return valueModels
        .map(
          (model) => model.toEntity()
        )
        .toList();
  }
}
