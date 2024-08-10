import 'dart:convert';
import 'package:carbids/domain/cars/cars_model.dart';
import 'package:flutter/material.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardWidget extends StatelessWidget {
  DashboardWidget({super.key});

  final TextEditingController _textEditingControllerYear =
    TextEditingController();

  final TextEditingController _textEditingControllerMake =
  TextEditingController();

  final TextEditingController _textEditingControllerModel =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CarsBloc carsBloc = BlocProvider.of<CarsBloc>(context);
    return BlocConsumer<CarsBloc, CarsState>(
      bloc: carsBloc,
      // Navigation in response to state change
      listener: (BuildContext context, CarsState state) {},
      listenWhen: (CarsState previous, CarsState current) {
        // Trigger BlocConsumer.listener only if a certain condition is satisfied
        return true;
      },
      buildWhen: (CarsState previous, CarsState current) {
        // Trigger BlocConsumer.builder only if a certain condition is satisfied
        return true;
      },
      // Build presentational data in response to state change
      builder: (BuildContext context, CarsState state) {
        return Scaffold(
          body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 48.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _textEditingControllerYear,
                        keyboardType: TextInputType.number,
                        onSubmitted: (String value) {
                          carsBloc.add(FetchCarsByMakesEvent(year: value));
                          _textEditingControllerMake.clear();
                          _textEditingControllerModel.clear();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Year',
                        ),
                      ),
                      TextField(
                        controller: _textEditingControllerMake,
                        keyboardType: TextInputType.text,
                        onSubmitted: (String value) {
                          carsBloc.add(FetchCarsByMakesEvent(make: value));
                          _textEditingControllerYear.clear();
                          _textEditingControllerModel.clear();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Make',
                        ),
                      ),
                      TextField(
                        controller: _textEditingControllerModel,
                        keyboardType: TextInputType.text,
                        onSubmitted: (String value) {
                          carsBloc.add(FetchCarsByYearsEvent(model: value));
                          _textEditingControllerYear.clear();
                          _textEditingControllerMake.clear();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Model',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildListView<int>(state.carsYears),
                          _buildListView<CarsModel>(state.carsMakes),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
          ),
        );
      },
    );
  }

  // https://dart.dev/language/generics
  Widget _buildListView<T>(List<T> items) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(20),
            width: double.maxFinite,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _cardText<T>(items[index])
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // https://github.com/dart-lang/language/issues/1997#issuecomment-982265741
  Type typeOf<X>() => X;

  String _cardText<T>(T item) {
    if (typeOf<T>() == CarsModel) {
      final carModel = item as CarsModel;
      return carModel.name;
    }
    return item.toString();
  }
}