import 'package:flutter/material.dart';

class DashboardController {
  /// Returns an instance of the binding that implements WidgetsBinding. If no binding has yet been initialized, the WidgetsFlutterBinding class is used to create and initialize one.
  /// Then, tell the framework to not send the first frames to the engine until there is a corresponding call to allowFirstFrame.
  static void preserve() {
    // This is the glue that binds the framework to the Flutter engine.
    // widgetsBinding handles the widget tree
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