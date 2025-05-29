part of 'init_dependencies.dart';


GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  _setupDio();
  getIt
    ..registerLazySingleton(() => SensorApi(getIt()))

    ..registerLazySingleton<SensorRepository>(() => SensorRepositoryImpl(getIt()))
    
    ..registerLazySingleton(() => GetSensorsUseCase(getIt()))
    ..registerLazySingleton(() => GetSensorValuesUseCase(getIt()))
    ..registerLazySingleton(() => GetNotificationsUseCase(getIt()))

    ..registerLazySingleton(() => WatchSensorsUseCase(getIt()))
    ..registerLazySingleton(() => WatchNotificationsUseCase(getIt()))
    
    ..registerLazySingleton(() => SensorsProvider(
      getSensorsUseCase: getIt(), 
      getSensorValuesUseCase: getIt(),
      watchSensorsUseCase: getIt(),
    ))
    ..registerLazySingleton(() => NotificationsProvider(
      getNotificationsUseCase: getIt(), 
      watchNotificationsUseCase: getIt(),
    ));
}

void _setupDio() {
  final dio = Dio();

  dio.options.baseUrl = 'http://213.177.102.64:1880/api/';
  dio.options.headers = {'Content-Type': 'application/json'};
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);

  getIt.registerSingleton<Dio>(dio);
}
