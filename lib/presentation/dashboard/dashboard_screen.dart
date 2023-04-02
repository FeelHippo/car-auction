import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:carbids/injector.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:carbids/presentation/dashboard/widgets/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<IOC>(
      builder: (context, ioc, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CarsBloc>(
                create: (_) => ioc.getDependency<CarsBloc>()
                  ..add(const FetchCarsEvent()),
            ),
          ],
          child: const DashboardWidget(),
        );
      },
    );
  }
}