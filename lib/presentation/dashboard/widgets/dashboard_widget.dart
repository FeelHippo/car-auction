import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carsBloc = BlocProvider.of<CarsBloc>(context);
    return LayoutBuilder(
        builder: (context, _constraints) {
          return BlocListener<CarsBloc, CarsState>(
            bloc: carsBloc,
            listener: (context, state) async {
              if (state.error != null) {
                // TODO: add error handler
              } else if (state.completed) {
                // TODO
              }
            },
            child: BlocBuilder<CarsBloc, CarsState>(
              bloc: carsBloc,
              builder: (context, state) {
                return Column(
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
                                    ? Image.memory(
                                        const Base64Decoder().convert(state.carModels![index].photo),
                                      )
                                    : Container()
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
    );
  }
}