import '../../domain/entities/sensor_entity.dart';


class SensorModel {
  final int id;
  final String name;
  final String type;
  final String unit;
  final String state;
  final double value;

  SensorModel({
    required this.id,
    required this.name,
    required this.type,
    required this.unit,
    required this.state,
    required this.value,
  });

  SensorModel toModel() {
    return SensorModel(
      id: id,
      name: name,
      type: type,
      unit: unit,
      state: state,
      value: value,
    );
  }

  SensorEntity toEntity() {
    return SensorEntity(
      id: id,
      name: name,
      type: type,
      unit: unit,
      state: state,
      value: value,
    );
  }


  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      unit: json['unit'] as String,
      state: json['state'] as String,
      value: double.parse(json['value'].toString()) //json['value'] as double,
    );
  }
}
