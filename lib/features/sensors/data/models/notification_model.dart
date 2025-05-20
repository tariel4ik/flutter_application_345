import 'package:flutter_application_345/features/sensors/domain/entities/notification_entity.dart';

class NotificationModel {
  final int id;
  final int sensorId;
  final String state;
  final DateTime timestamp;

  const NotificationModel({
    required this.id,
    required this.sensorId,
    required this.state,
    required this.timestamp,
  });

  // Превращает Model в Entity (для слоя domain)
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      sensorId: sensorId,
      state: state,
      timestamp: timestamp,
    );
  }

  // Можно использовать как "копию" или фабричный метод
  NotificationModel toModel() {
    return NotificationModel(
      id: id,
      sensorId: sensorId,
      state: state,
      timestamp: timestamp,
    );
  }

    // Для совместимости — можно использовать для преобразования Map -> Model
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int? ?? 0,
      sensorId: json['sensor_id'] as int? ?? 0,
      state: json['state'] as String? ?? '',
      timestamp: DateTime.parse(
        json['timestamp'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
