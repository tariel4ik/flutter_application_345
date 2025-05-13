import 'package:flutter/material.dart';
import 'package:flutter_application_345/features/sensors/presentation/providers/sensor_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/device_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем размеры экрана
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06, // 6% от ширины экрана
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: screenWidth * 0.025, // Тень зависит от ширины
      ),
      body: Consumer<SensorProvider>(
        builder: (BuildContext context, SensorProvider value, Widget? child) {
          return Container(
            height: screenHeight, // Полная высота экрана
            width: screenWidth, // Полная ширина экрана
            color: Colors.white,
            child: DeviceGrid(devices: value.sensors),
          );
        },
      ),
    );
  }
}
