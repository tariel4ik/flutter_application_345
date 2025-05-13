import 'package:flutter/material.dart';
import 'package:flutter_application_345/features/sensors/presentation/providers/sensor_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routerDelegate: AppRouter.router.routerDelegate,
      builder: (context, child) => MultiProvider(
        providers: [ 
          ChangeNotifierProvider<SensorProvider>(create: (_) => GetIt.I<SensorProvider>()..loadSensors())
        ],
        child: child,
      ),
    );
    
  }
}