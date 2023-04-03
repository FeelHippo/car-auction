import 'package:flutter/material.dart';

class DashboardController {
  static void preserve() {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();
  }
  static void remove() {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    if (!binding.sendFramesToEngine) {
      binding.allowFirstFrame();
    }
  }
}