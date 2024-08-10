import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:carbids/injector.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:carbids/presentation/dashboard/widgets/dashboard_widget.dart';
import 'package:provider/single_child_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumes IOC Provider: all injected dependencies are available
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? child) {
        // Merges multiple BlocProvider widgets into one widget tree
        return MultiBlocProvider(
          // Instantiate all relevant blocs here
          providers: <SingleChildWidget>[
            BlocProvider(
              create: (BuildContext context) {
                return ioc.getDependency<CarsBloc>();
              },
            ),
            // ... more can be added here
          ],
          child: DashboardWidget(),
        );
      },
    );
  }
}