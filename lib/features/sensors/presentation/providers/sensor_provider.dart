  // lib/presentation/providers/sensor_provider.dart
  import 'package:flutter/material.dart';
  import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';
  import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
  import 'package:flutter_application_345/features/sensors/domain/usecases/get_sensor_values_use_case.dart';
  import 'package:flutter_application_345/features/sensors/domain/usecases/get_sensors_use_case.dart';


  class SensorProvider with ChangeNotifier {
    final GetSensorsUseCase getSensorsUseCase;
    final GetSensorValuesUseCase getSensorValuesUseCase;

    List<SensorEntity> _sensors = [];
    List<SensorValueEntity> _sensorValues = [];
    String? _errorMessage;
    bool _isLoading = false;

    SensorProvider({
      required this.getSensorsUseCase,
      required this.getSensorValuesUseCase,
    }) {
      loadSensors();
    }

    List<SensorEntity> get sensors => _sensors;
    List<SensorValueEntity> get sensorValues => _sensorValues;
    String? get errorMessage => _errorMessage;
    bool get isLoading => _isLoading;

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
  }
