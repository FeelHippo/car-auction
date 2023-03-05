import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:carbids/analytics/analytics.dart';
import 'package:carbids/injector.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:carbids/presentation/widgets/app_scaffold.dart';
import 'package:carbids/presentation/dashboard/widgets/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: ScreenSource.dashboard,
      child: AppScaffold(
        // TODO: add systemUiOverlayStyleIOS
        body: Consumer<IOC>(
          builder: (context, ioc, child) {
            final carsBloc = ioc.getDependency<CarsBloc>();
            return MultiBlocProvider(
                providers: [
                  BlocProvider<CarsBloc>.value(value: carsBloc),
                ],
                child: DashboardWidget(),
            )
          },
        ),
      ),
    );
  }
}