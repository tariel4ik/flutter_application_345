// lib/presentation/providers/sensor_provider.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/usecases/get_notifications_use_case.dart';
import 'package:flutter_application_345/features/sensors/domain/usecases/get_sensor_values_use_case.dart';
import 'package:flutter_application_345/features/sensors/domain/usecases/get_sensors_use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/watch_notifications_use_case.dart';

class SensorProvider with ChangeNotifier {
  final GetSensorsUseCase getSensorsUseCase;
  final GetSensorValuesUseCase getSensorValuesUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  final WatchNotificationsUseCase watchNotificationsUseCase;

  List<SensorEntity> _sensors = [];
  List<SensorValueEntity> _sensorValues = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<NotificationEntity> notifications = [];

  StreamSubscription<Either<Failure, List<NotificationEntity>>>? _sub;

  SensorProvider({
    required this.getSensorsUseCase,
    required this.getSensorValuesUseCase,
    required this.getNotificationsUseCase,
    required this.watchNotificationsUseCase,
  }) {
    loadSensors();
    _subscribeToStream();
  }

  List<SensorEntity> get sensors => _sensors;
  List<SensorValueEntity> get sensorValues => _sensorValues;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> loadSensors() async {
    _isLoading = true;
    notifyListeners();

    final result = await getSensorsUseCase.execute();
    result.fold(
      (error) {
        _errorMessage = error;

        _sensors = [];
      },
      (data) {
        _sensors = data;
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadSensorValues(int sensorId) async {
    _isLoading = true;
    notifyListeners();

    final result = await getSensorValuesUseCase.execute(sensorId);
    result.fold(
      (error) {
        _errorMessage = error;
        _sensorValues = [];
      },
      (data) {
        _sensorValues = data;
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _subscribeToStream() {
    _sub = watchNotificationsUseCase().listen((either) {
      either.match(
        (f) {
          print(f.message);
          notifications = [];
          notifyListeners();
        },
        (newItems) {
          notifications = newItems;
          notifyListeners();
        },
      );
    });
  }

  void reset() {
    _sub?.cancel();
    _sub = null;
    notifications.clear();
    _isLoading = false;
    _subscribeToStream();
    notifyListeners();
  }
}
