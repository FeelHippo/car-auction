import 'package:carbids/domain/cars/cars_interactor.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';
import 'package:injector/injector.dart';

class BlocModule {
  static CarsBloc createCarsBloc(Injector injector) => CarsBloc(injector.get<CarsInteractor>());
}