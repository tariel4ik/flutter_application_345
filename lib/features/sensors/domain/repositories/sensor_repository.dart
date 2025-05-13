
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';

import '../entities/sensor_entity.dart';

abstract class SensorRepository {
  Future<List<SensorEntity>> getSensors();
  Future<List<SensorValueEntity>> getSensorValues(int sensorId);
}
