
import 'package:dio/dio.dart';
import 'package:flutter_application_345/features/sensors/domain/repositories/sensor_repository.dart';
import 'package:flutter_application_345/features/sensors/data/api/sensor_api.dart';
import 'package:flutter_application_345/features/sensors/data/repositories/sensor_repository.dart';
import 'package:flutter_application_345/features/sensors/domain/usecases/get_sensor_values_use_case.dart';
import 'package:flutter_application_345/features/sensors/domain/usecases/get_sensors_use_case.dart';
import 'package:flutter_application_345/features/sensors/presentation/providers/sensor_provider.dart';
import 'package:get_it/get_it.dart';
part 'init_dependencies.main.dart';
