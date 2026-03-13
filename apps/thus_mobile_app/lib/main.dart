import 'package:flutter/material.dart';

import 'app.dart';
import 'di/di.dart';

Future<void> main() async {
  await configureAppDependencies();
  runApp(const ThusApp());
}
