import 'package:flutter/material.dart';

import '../../domain/entities/sensor_entity.dart';
import 'device_card.dart';


class DeviceGrid extends StatelessWidget {
  final List<SensorEntity> devices;

  const DeviceGrid({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    if (screenWidth <= 0) {
      return const SizedBox.shrink();
    }

    final baseWidth = 375.0;
    final scaleFactor = screenWidth / baseWidth;

    if (scaleFactor.isNaN || scaleFactor <= 0) {
      return const SizedBox.shrink();
    }

    final maxCrossAxisExtent = 180.0 * scaleFactor;

    return GridView.builder(
      padding: EdgeInsets.all(16.0 * scaleFactor),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        crossAxisSpacing: 16.0 * scaleFactor,
        mainAxisSpacing: 16.0 * scaleFactor,
        childAspectRatio: 0.7, //0.85
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return DeviceCard(sensor: device);
      },
    );
  }
}

