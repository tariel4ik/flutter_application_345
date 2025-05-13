import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';

class SensorValueModel {
  final String id;
  final int sensorId;
  final double value;
  final DateTime timestamp;

  SensorValueModel({
    required this.id,
    required this.sensorId,
    required this.value,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'sensor_id': sensorId,
    'value': value,
    'timestamp': timestamp.toIso8601String(),
  };

  SensorValueEntity toEntity() {
    return SensorValueEntity(
      id: id,
      sensorId: sensorId,
      value: value,
      timestamp: timestamp,
    );
  }

  SensorValueModel toModel() {
    return SensorValueModel(
      id: id,
      sensorId: sensorId,
      value: value,
      timestamp: timestamp,
    );
  }

  factory SensorValueModel.fromJson(Map<String, dynamic> json) {
    return SensorValueModel(
      id: json['id'] as String,
      sensorId: (json['sensor_id'] as num).toInt(),
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
