import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/sensor_value_entity.dart';


class SensorChart extends StatelessWidget {
  final List<SensorValueEntity> data;

  const SensorChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.Hms(); // ('dd.MM HH:mm');
    String varTime = "Время";
    String varValue = "Значение";
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: 260,
      child: Chart(
        data: data,
        variables: {
          varTime: Variable(
            accessor: (dynamic d) => (d as SensorValueEntity).timestamp.toLocal(),
            scale: TimeScale(
              formatter: (time) => dateFormat.format(time),
              tickCount: 4,
            ),
          ),
          varValue: Variable(
            accessor: (dynamic d) => (d as SensorValueEntity).value,
            scale: LinearScale(
              tickCount: 3,
            ),
          ),
        },
        marks: [
          AreaMark(
            position: Varset(varTime) * Varset(varValue),
            color: ColorEncode(
              value: Colors.blue.withValues(alpha: 0.2),
            ),
          ),
          LineMark(
            position: Varset(varTime) * Varset(varValue),
            shape: ShapeEncode(value: BasicLineShape()),
            color: ColorEncode(value: Colors.blue),
            size: SizeEncode(value: 2),
          ),
          // Точки на линии
          PointMark(
            position: Varset(varTime) * Varset(varValue),
            color: ColorEncode(value: Colors.blue),
            size: SizeEncode(value: 3),
          ),
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {
          'tap': PointSelection(
            on: {GestureType.tapDown, GestureType.longPress},
            dim: Dim.x,
          ),
        },
        tooltip: TooltipGuide(
          followPointer: [false, true],
          align: Alignment.topLeft,
        ),
        crosshair: CrosshairGuide(
          followPointer: [false, true],
        ),
      ),
    );
  }
}