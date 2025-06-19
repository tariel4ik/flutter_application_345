import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/sensor_entity.dart';
import '../providers/sensors_provider.dart';
import '../widgets/sensor_chart.dart';


class SensorDetailsBottomSheet extends StatelessWidget {
  final SensorEntity sensor;

  const SensorDetailsBottomSheet({super.key, required this.sensor});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                sensor.name.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.05),
          Text(
            'Подробности датчика',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
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
            ),
          Consumer<SensorsProvider>(
            builder: (context, value, child) {
              return SensorChart(data: value.sensorValues);
            },
          ),
        ],
      ),
    );
  }
}