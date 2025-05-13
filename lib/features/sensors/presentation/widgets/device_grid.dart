import 'package:flutter/material.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';

import 'device_card.dart';

class DeviceGrid extends StatelessWidget {
  final List<SensorEntity> devices;

  const DeviceGrid({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = 375.0; // Базовая ширина для масштабирования
    final scaleFactor = screenWidth / baseWidth;

    return GridView.builder(
      padding: EdgeInsets.all(16.0 * scaleFactor),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180.0 * scaleFactor,
        crossAxisSpacing: 16.0 * scaleFactor,
        mainAxisSpacing: 16.0 * scaleFactor,
        childAspectRatio:
            0.7, // Уменьшаем соотношение, чтобы карточки были выше
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return DeviceCard(sensor: device);
      },
    );
  }
}
