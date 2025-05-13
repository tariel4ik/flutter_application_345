import 'package:flutter/material.dart';
import 'package:flutter_application_345/core/app.dart';
import 'package:flutter_application_345/core/router/app_router.dart';
import 'package:flutter_application_345/init_dependencies.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppRouter.initialize();
  await initDependencies();
  runApp(const App());
}

