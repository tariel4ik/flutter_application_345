import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/app.dart';
import 'core/router/app_router.dart';
import 'init_dependencies.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    initializeDateFormatting('ru', null),
    AppRouter.initialize(),
    initDependencies(),
  ]);

  runApp(const App());
}

