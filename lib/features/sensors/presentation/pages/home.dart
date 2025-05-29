import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sensors_provider.dart';
import '../widgets/device_grid.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06,
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
        elevation: screenWidth * 0.025,
      ),
      body: Consumer<SensorsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          
          return Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
            child: DeviceGrid(devices: provider.sensors),
          );
        },
      ),
    );
  }
}
