class SensorEntity {
  final int id;
  final String name;
  final String type;
  final String unit;
  final String state;
  final double value;

  const SensorEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.unit,
    required this.state,
    required this.value,
  });

  SensorEntity copyWith({
    int? id,
    String? name,
    String? type,
    String? unit,
    String? state,
    double? value,
  }) {
    return SensorEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      state: state ?? this.state,
      value: value ?? this.value,
    );
  }  

  @override
  String toString() {
    return 'SensorEntity(id: $id, name: $name, type: $type, unit: $unit, state: $state, value: $value)';
  }
}
