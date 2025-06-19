import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/sensor_entity.dart';
import '../pages/sensor_details_bottom_sheet.dart';
import '../providers/sensors_provider.dart';

class DeviceCard extends StatelessWidget {
  final SensorEntity sensor;

  const DeviceCard({super.key, required this.sensor});

  void _showDeviceDetails(BuildContext context, SensorEntity sensor) {
    final screenWidth = MediaQuery.of(context).size.width;

    final sensorProvider = GetIt.I<SensorsProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await sensorProvider.loadSensorValues(sensor.id);
    });

    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Consumer<SensorsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator()
                );
              } else if (provider.sensorValues.isEmpty) {
                return const Center(
                  child: Text("EMPTY!")
                );
              }
              
              return SensorDetailsBottomSheet(sensor: sensor);
            }
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = 375.0;
    final scaleFactor = screenWidth / baseWidth;


    return GestureDetector(
      onTap: () => _showDeviceDetails(context, sensor),
      child: Card(
        elevation: 4.0 * scaleFactor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0 * scaleFactor),
        ),
        color: Colors.white.withValues(alpha: 0.9),
        child: Padding(
          padding: EdgeInsets.all(12.0 * scaleFactor),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  sensor.type == "temperature" 
                    ? Icons.whatshot
                    : Icons.water_drop,
                  color: Colors.deepPurple,
                  size: 48.0 * scaleFactor,
                ),
                SizedBox(height: 8.0 * scaleFactor),
                Text(
                  sensor.type,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0 * scaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0 * scaleFactor),
                Text(
                  'состояние: ${sensor.state}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0 * scaleFactor,
                  ),
                ),
                 SizedBox(height: 6.0 * scaleFactor),
                Text(
                  'значение: ${sensor.value} ${sensor.unit}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0 * scaleFactor,
                  ),
                ),
                SizedBox(height: 6.0 * scaleFactor),
                Text(
                  "",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 14.0 * scaleFactor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
