
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/sensors/data/api/sensor_api.dart';
import 'features/sensors/data/repositories/sensor_repository_impl.dart';
import 'features/sensors/domain/repositories/sensor_repository.dart';
import 'features/sensors/domain/usecases/get_notifications_use_case.dart';
import 'features/sensors/domain/usecases/get_sensor_values_use_case.dart';
import 'features/sensors/domain/usecases/get_sensors_use_case.dart';
import 'features/sensors/domain/usecases/watch_notifications_use_case.dart';
import 'features/sensors/presentation/providers/sensor_provider.dart';
part 'init_dependencies.main.dart';
