import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:carbids/injector.dart';
import 'package:carbids/presentation/themes.dart';
import 'package:carbids/presentation/widgets/scope_widget.dart';

void main() {
  initApp();
}

Future<void> initApp() async {
  runZonedGuarded<Future>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(App(scope: IOC.appScope()));
    Bloc.observer = SimpleBlocDelegate();
  });
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
        home: DashboardScreen(),
      ),
    );
  }
}
