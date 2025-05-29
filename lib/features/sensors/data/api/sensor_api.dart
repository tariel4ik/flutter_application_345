import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../models/sensor_model.dart';
import '../models/sensor_value_model.dart';


class SensorApi {
  final Dio _dio;

  SensorApi(this._dio);
  Future<List<SensorModel>> getSensors() async {
    try {
      final response = await _dio.get(
        '/sensors/',
        options: Options(responseType: ResponseType.plain),
      );

      dynamic raw = response.data;
      if (raw is String) {
        raw = jsonDecode(raw);
      }
      return (raw as List)
        .map((item) => SensorModel.fromJson(item))
        .toList();
    } catch (e) {
      throw Exception('Failed to load sensors: $e');
    }
  }

  Future<List<SensorValueModel>> getSensorValues(int sensorId) async {
    try {
      final response = await _dio.get(
        '/values/$sensorId',
        options: Options(responseType: ResponseType.plain),
      );

      dynamic raw = response.data;
      if (raw is String) {
        raw = jsonDecode(raw);
      }

      return (raw as List)
        .map((item) => SensorValueModel.fromJson(item))
        .toList();
    } catch (e) {
      throw Exception('Failed to load sensor values: $e');
    }
  }

  Future<List<NotificationModel>> getNotifications({
    DateTime? since,
  }) async {
    try {
      String? endpoint;
      if (since != null) {
        endpoint = "'${since.toLocal().toIso8601String()}'";
      } else {
        endpoint = "'${DateTime.now().toLocal().toIso8601String()}'";
      }
      final resp = await _dio.get(
        '/notifications/$endpoint',
        options: Options(responseType: ResponseType.plain),
      );

      dynamic raw = resp.data;
      if (raw is String) {
        raw = jsonDecode(raw);
      }

      if (raw == null || raw is! List<dynamic> || raw.isEmpty) {
        return [];
      }

      return raw
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
    } catch (e) {
      rethrow;
    }
  }


  Stream<List<NotificationModel>> watchNotifications({
    Duration interval = const Duration(seconds: 2),
  }) async* {
    while (true) {
      try {
        final items = await getNotifications(since: DateTime.now().toLocal().subtract(interval));
        final filtered = items
          .where((n) => n.state.toLowerCase() != 'normal')
          .toList();
        if (filtered.isNotEmpty) {
          yield filtered;
        }
        debugPrint("Update notifications");
      } catch (e) {
        debugPrint('Error polling notifications: $e');
      }
      await Future.delayed(interval);
    }
  }

  Stream<List<SensorModel>> watchSensors({
    Duration interval = const Duration(seconds: 2),
  }) async* {
    while (true) {
      try {
        final items = await getSensors();
        if (items.isNotEmpty) {
          yield items;
        }
        debugPrint("Update sensors");
      } catch (e) {
        debugPrint('Error polling sensors data: $e');
      }
      await Future.delayed(interval);
    }
  }
}
