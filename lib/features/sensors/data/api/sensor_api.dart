import 'package:dio/dio.dart';
import '../models/notification_model.dart';
import '../models/sensor_model.dart';
import '../models/sensor_value_model.dart';

class SensorApi {
  final Dio _dio;

  SensorApi(this._dio);
  Future<List<SensorModel>> getSensors() async {
    try {
      final response = await _dio.get('/sensors/');
      return (response.data as List)
          .map((item) => SensorModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load sensors: $e');
    }
  }

  Future<List<SensorValueModel>> getSensorValues(int sensorId) async {
    try {
      final response = await _dio.get('/values/$sensorId');
      final values =
          (response.data as List)
              .map((item) => SensorValueModel.fromJson(item))
              .toList();
      return values;
    } catch (e) {
      throw Exception('Failed to load sensor values: $e');
    }
  }

  Future<List<NotificationModel>> fetchNotifications({
    DateTime? since,
  }) async {
    try {
      String? endpoint;
      if (since != null) {
        endpoint = "'${since.toUtc().toIso8601String()}'";
      } else {
        endpoint = "'${DateTime.now().toIso8601String()}'";
      }
      final resp = await _dio.get('/notifications/$endpoint');

      final raw = resp.data;
      if (raw == null || raw is! List<dynamic> || raw.isEmpty) {
        return [];
      }

      return raw
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }


  Stream<List<NotificationModel>> watchNotifications({
    Duration interval = const Duration(seconds: 2),
  }) async* {
    // DateTime? lastFetched;
    while (true) {
      try {
        final items = await fetchNotifications(since: DateTime.now().subtract(interval));
        if (items.isNotEmpty) {
          // lastFetched = items
          //     .map((i) => i.timestamp)
          //     .reduce((a, b) => a.isAfter(b) ? a : b);
          // lastFetched = DateTime.now();
          yield items;
        }
      } catch (e) {
        print('Error polling notifications: $e');
      }
      await Future.delayed(interval);
    }
  }
}
