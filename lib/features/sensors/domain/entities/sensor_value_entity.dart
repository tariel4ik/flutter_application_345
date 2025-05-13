class SensorValueEntity {
  final String id;
  final int sensorId;
  final double value;
  final DateTime timestamp;

  const SensorValueEntity({
    required this.id,
    required this.sensorId,
    required this.value,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'SensorValueEntity(id: $id, sensorId: $sensorId, value: $value, timestamp: $timestamp)';
  }

  SensorValueEntity copyWith({
    String? id,
    int? sensorId,
    double? value,
    DateTime? timestamp,
  }) {
    return SensorValueEntity(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
