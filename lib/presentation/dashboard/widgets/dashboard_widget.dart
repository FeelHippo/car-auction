import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key, required this.carsBloc}) : super(key: key);

  final CarsBloc carsBloc;

  @override
  State<StatefulWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  late CarsBloc carsBloc;
  
  @override
  void initState() {
    super.initState();
    carsBloc = BlocProvider.of<CarsBloc>(context)..add(const FetchCarsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, _constraints) {
          return BlocConsumer<CarsBloc, CarsState>(
            bloc: carsBloc,
            listener: (context, state) async {
              if (state.error != null) {
                // TODO: add error handler
              } else if (state.completed) {
                // TODO
              }
            },
            builder: (context, state) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.carModels?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            width: double.maxFinite,
                            child: Card(
                              elevation: 10,
                              child: state.carModels?[index] != null
                                  ? Image.memory(base64Decode(state.carModels![index].photo))
                                  : Container()
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }
}