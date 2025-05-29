import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/sensor_entity.dart';
import '../../domain/entities/sensor_value_entity.dart';
import '../../domain/usecases/get_sensor_values_use_case.dart';
import '../../domain/usecases/get_sensors_use_case.dart';
import '../../domain/usecases/watch_sensors_use_case.dart';


class SensorsProvider with ChangeNotifier {
  final GetSensorsUseCase _getSensorsUseCase;
  final GetSensorValuesUseCase _getSensorValuesUseCase;
  final WatchSensorsUseCase _watchSensorsUseCase;

  List<SensorEntity> _sensors = [];
  List<SensorValueEntity> _sensorValues = [];
  Failure? _failure;
  bool _isLoading = false;

  StreamSubscription<Either<Failure, List<SensorEntity>>>? _sensorsSub;

  SensorsProvider({
    required GetSensorsUseCase getSensorsUseCase,
    required GetSensorValuesUseCase getSensorValuesUseCase,
    required WatchSensorsUseCase watchSensorsUseCase,
  })  : _getSensorsUseCase = getSensorsUseCase,
        _getSensorValuesUseCase = getSensorValuesUseCase,
        _watchSensorsUseCase = watchSensorsUseCase {
    _loadSensors();
    _subscribeToSensorsStream();
  }

  List<SensorEntity> get sensors => _sensors;
  List<SensorValueEntity> get sensorValues => _sensorValues;
  Failure? get failure => _failure;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _sensorsSub?.cancel();
    super.dispose();
  }

  Future<void> _loadSensors() async {
    _setLoading(true);
    final result = await _getSensorsUseCase.call();
    result.fold(
      (failure) {
        _failure = failure;
        _sensors = [];
      },
      (data) {
        _sensors = data;
        _failure = null;
      },
    );
    _setLoading(false);
  }

  Future<void> loadSensorValues(int sensorId) async {
    _setLoading(true);
    final result = await _getSensorValuesUseCase.call(sensorId: sensorId);
    result.fold(
      (failure) {
        _failure = failure;
        _sensorValues = [];
      },
      (data) {
        _sensorValues = data;
        _failure = null;
      },
    );
    _setLoading(false);
  }

  void clearError() {
    _failure = null;
    notifyListeners();
  }

  void _subscribeToSensorsStream() {
    _sensorsSub = _watchSensorsUseCase().listen((either) {
      either.match(
        (failure) {
          _failure = failure;
          _sensors = [];
        },
        (newSensors) {
          _sensors = newSensors;
          _failure = null;
        },
      );
      notifyListeners();
    });
  }

  void reset() {
    _sensorsSub?.cancel();
    _sensorsSub = null;
    _sensors = [];
    _sensorValues = [];
    _failure = null;
    _isLoading = false;
    _subscribeToSensorsStream();
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
