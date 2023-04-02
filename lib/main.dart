import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:carbids/utils/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:carbids/injector.dart';
import 'package:carbids/presentation/themes.dart';
import 'package:carbids/presentation/dashboard/dashboard_screen.dart';
import 'package:carbids/presentation/widgets/scope_widget.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';

void main() {
  initApp();
}

Future<void> initApp() async {
  runZonedGuarded<Future>(
          () async {

            WidgetsFlutterBinding.ensureInitialized();
            DashboardController.preserve();

            final ioc = IOC.appScope();
            runApp(
                App(scope: ioc),
            );

            Bloc.observer = SimpleBlocDelegate();
            DashboardController.remove();
          },
        (error, stackTrace) => print('${error.toString()}, ${stackTrace}'), // TODO: replace this
  );
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

class App extends StatelessWidget {
  final IOC scope;

  const App({Key? key, required this.scope}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopeWidget(
      scope: scope,
      // TODO: add AppConfigurationProvider with generated config
      child: MaterialApp(
        theme: AppTheme.androidTheme(),
        home: const DashboardScreen(),
      ),
    );
  }
}
