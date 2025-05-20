class NotificationEntity {
  final int id;
  final int sensorId;
  final String state;
  final DateTime timestamp;

  const NotificationEntity({
    required this.id,
    required this.sensorId,
    required this.state,
    required this.timestamp,
  });

  // Копирование с изменением некоторых полей
  NotificationEntity copyWith({
    int? id,
    int? sensorId,
    String? state,
    DateTime? timestamp,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      state: state ?? this.state,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'NotificationEntity(id: $id, sensorId: $sensorId, state: $state, timestamp: $timestamp)';
  }
}
