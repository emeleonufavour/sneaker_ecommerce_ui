import 'package:flutter/material.dart';

import 'app_setup.locator.dart';

class App {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
  }
}
