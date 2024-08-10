import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:carbids/utils/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:carbids/injector.dart';
import 'package:carbids/presentation/themes.dart';
import 'package:carbids/presentation/dashboard/dashboard_screen.dart';
import 'package:carbids/presentation/widgets/scope_widget.dart';



void main() {
  runZonedGuarded<Future<void>>(
        () async {
          DashboardController.preserve();

          final ioc = IOC.appScope();

          runApp(App(scope: ioc));

          Bloc.observer = SimpleBlocDelegate();
          DashboardController.remove();
        },
        (error, stackTrace) =>
            debugPrint(
              '${error.toString()}, $stackTrace',
            ),
  );
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugPrint('|--- Bloc $bloc: error $error');
  }
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('|--- Bloc $bloc: event $event');
  }
}

class App extends StatelessWidget {
  const App({super.key, required this.scope});
  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return ScopeWidget(
      scope: scope,
      child: MaterialApp(
        theme: AppTheme.androidTheme(),
        home: const DashboardScreen(),
      ),
    );
  }
}
