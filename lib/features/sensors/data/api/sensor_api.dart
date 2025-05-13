import 'package:dio/dio.dart';
import '../models/sensor_model.dart';
import '../models/sensor_value_model.dart';

class SensorApi {
  final Dio _dio;

  SensorApi(this._dio);
  Future<List<SensorModel>> getSensors() async {
    try {
      // final String jsonString = await rootBundle.loadString(
      //   'assets/sensors.json',
      // );
      // final List<dynamic> json = jsonDecode(jsonString);
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
      // final String jsonString = await rootBundle.loadString(
      //   'assets/values.json',
      // );
      // final List<dynamic> json = jsonDecode(
      //   jsonString,
      // ); // Доступ к первому вложенному списку

      final response = await _dio.get('/values/$sensorId');
      final values =
          (response.data as List)
              .map((item) => SensorValueModel.fromJson(item))
              // .where((model) => model.sensorId == sensorId)
              .toList();
      print(response.data);
      return values;
    } catch (e) {
      throw Exception('Failed to load sensor values: $e');
    }
  }
}
