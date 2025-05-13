import 'package:flutter/material.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
import 'package:flutter_application_345/features/sensors/presentation/providers/sensor_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SensorDetailsBottomSheet extends StatelessWidget {
  final SensorEntity sensor;

  const SensorDetailsBottomSheet({super.key, required this.sensor});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final monthDayFormat = DateFormat('HH:mm');
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04), // Отступ 4% от ширины
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                // 'DS18B20',
                sensor.name.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.045, // Шрифт 4.5% от ширины
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.05),
          Text(
            'Details sensor',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
              // Шрифт 3% от ширины
            ),
          ),
          Divider(color: Colors.purpleAccent),
          if (sensor.type == "temperature")
            ListTile(
              leading: Icon(
                Icons.thermostat,
                color: Colors.red,
                size: screenWidth * 0.07,
              ),
              title: Text(
                'temperature: ${sensor.value.toStringAsFixed(2)}°C',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              onTap: () {
                context.go('/state_page', extra: sensor.name);
              },
            ),
          if (sensor.type == "humidity")
            ListTile(
              leading: Icon(
                Icons.water_drop,
                color: Colors.blue,
                size: screenWidth * 0.07,
              ),
              title: Text(
                
                'humidity: ${sensor.value.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              onTap: () {
                context.go('/state_page', extra: sensor.name);
              },
            ),
          Consumer<SensorProvider>(
            builder: (context, value, child) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                width: 350,
                height: 300,
                child: Chart(
                  data: value.sensorValues,
                  variables: {
                    'time': Variable(
                      accessor: (SensorValueEntity datum) => datum.timestamp,

                      scale: TimeScale(
                        formatter: (time) => monthDayFormat.format(time),
                      ),
                    ),
                    'values': Variable(
                      accessor: (SensorValueEntity datum) => datum.value.toStringAsFixed(2),
                    ),
                  },
                  marks: [
                    LineMark(
                      shape: ShapeEncode(value: BasicLineShape(dash: [5, 2])),
                      selected: {
                        'touchMove': {1},
                      },
                    ),
                  ],
                  coord: RectCoord(color: const Color(0xffdddddd)),
                  axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
                  selections: {
                    'touchMove': PointSelection(
                      on: {
                        GestureType.scaleUpdate,
                        GestureType.tapDown,
                        GestureType.longPressMoveUpdate,
                      },
                      dim: Dim.x,
                    ),
                  },
                  tooltip: TooltipGuide(
                    followPointer: [false, true],
                    align: Alignment.topLeft,
                    offset: const Offset(-20, -20),
                  ),
                  crosshair: CrosshairGuide(followPointer: [false, true]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
