import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_345/core/app.dart';


void main() {
  runApp(App());
}

class HomePage extends StatelessWidget {
  final List<Device> devices = [
    Device(
      name: 'Датчик температуры 1',
      state: '100%',
      icon: Icons.energy_savings_leaf_outlined,
      temp: 23,
      humidity: 45,
    ),
    Device(
      name: 'Датчик температуры 2',
      state: '100%',
      icon: Icons.power_outlined,
      temp: 25,
      humidity: 85,
    ),
    Device(
      name: 'Датчик температуры 3',
      state: '100%',
      icon: Icons.speed,
      temp: 20,
      humidity: 60,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Получаем размеры э
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Датчики',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: screenWidth * 0.07,
              color: Colors.white,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Данные обновлены',
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: screenHeight, // Полная высота экрана
        width: screenWidth, // Полная ширина экрана
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: DeviceGrid(devices: devices),
      ),
    );
  }
}

class Device {
  final String name;
  final String state;
  final IconData icon;
  final int temp;
  final int humidity;

  Device({
    required this.name,
    required this.state,
    required this.icon,
    required this.temp,
    required this.humidity,
  });
}

class DeviceGrid extends StatelessWidget {
  final List<Device> devices;

  const DeviceGrid({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      padding: EdgeInsets.all(screenWidth * 0.04), // Отступ 4% от ширины
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            screenWidth * 0.45, // Максимальная ширина карточки — 45% экрана
        crossAxisSpacing: screenWidth * 0.04, // Отступ между столбцами
        mainAxisSpacing: screenWidth * 0.04, // Отступ между строками
        childAspectRatio: 0.8,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return DeviceCard(device: device);
      },
    );
  }
}

class DeviceCard extends StatelessWidget {
  final Device device;

  const DeviceCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => _showDeviceDetails(context, device),
      child: Card(
        elevation: screenWidth * 0.02, // Тень зависит от ширины
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            screenWidth * 0.05,
          ), // Радиус 5% от ширины
        ),
        color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03), // Отступ 3% от ширины
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                device.icon,
                color: Colors.deepPurple,
                size: screenWidth * 0.12, // Размер иконки — 12% от ширины
              ),
              SizedBox(height: screenWidth * 0.025), // Отступ 2.5% от ширины
              Text(
                device.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: screenWidth * 0.04, // Шрифт 4% от ширины
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.0125), // Отступ 1.25% от ширины
              Text(
                'Состояние: ${device.state}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.035, // Шрифт 3.5% от ширины
                ),
              ),
              SizedBox(height: screenWidth * 0.0125),
              Text(
                '${device.temp}°C | ${device.humidity}%',
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeviceDetails(BuildContext context, Device device) {
  final screenWidth = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    barrierColor: Colors.deepPurpleAccent.withOpacity(0.5),
    backgroundColor: Colors.black,
    context: context,
    builder: (context) {
      return DeviceDetailsBottomSheet(device: device);
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(screenWidth * 0.05),
      ),
    ),
  );
}

class DeviceDetailsBottomSheet extends StatelessWidget {
  final Device device;

  const DeviceDetailsBottomSheet({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04), // Отступ 4% от ширины
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                device.icon,
                size: screenWidth * 0.1, // Иконка 10% от ширины
                color: Colors.white,
              ),
              SizedBox(width: screenWidth * 0.025),
              Text(
                device.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.045, // Шрифт 4.5% от ширины
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.05),
          Text(
            'Детали датчика',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.03, // Шрифт 3% от ширины
            ),
          ),
          Divider(color: Colors.green),
          ListTile(
            leading: Icon(
              Icons.battery_full,
              color: Colors.green,
              size: screenWidth * 0.07,
            ),
            title: Text(
              'Состояние: ${device.state}',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: screenWidth * 0.04,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatePage(state: device.state),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.thermostat,
              color: Colors.red,
              size: screenWidth * 0.07,
            ),
            title: Text(
              'Температура: ${device.temp}°C',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: screenWidth * 0.04,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemperaturePage(temp: device.temp),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.water_drop,
              color: Colors.blue,
              size: screenWidth * 0.07,
            ),
            title: Text(
              'Влажность: ${device.humidity}%',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: screenWidth * 0.04,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HumidityPage(humidity: device.humidity),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StatePage extends StatelessWidget {
  final String state;

  const StatePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Состояние датчика',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
      ),
      body: Center(
        child: Text(
          'Состояние: $state',
          style: TextStyle(
            fontSize: screenWidth * 0.06, // Шрифт 6% от ширины
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class TemperaturePage extends StatelessWidget {
  final int temp;

  const TemperaturePage({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Температура',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
      ),
      body: Center(
        child: Text(
          'Температура: $temp°C',
          style: TextStyle(fontSize: screenWidth * 0.06, color: Colors.red),
        ),
      ),
    );
  }
}

class HumidityPage extends StatelessWidget {
  final int humidity;

  const HumidityPage({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Влажность',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
      ),
      body: Center(
        child: Text(
          'Влажность: $humidity%',
          style: TextStyle(fontSize: screenWidth * 0.06, color: Colors.blue),
        ),
      ),
    );
  }
}
