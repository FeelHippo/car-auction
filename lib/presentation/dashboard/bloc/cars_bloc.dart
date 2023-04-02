import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:carbids/domain/cars/cars_interactor.dart';
import 'package:carbids/domain/cars/car_model.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {

  final CarsInteractor _carsInteractor;

  CarsBloc(this._carsInteractor) : super(const CarsState()) {
    on<FetchCarsEvent>((event, emit) async {

      emit(const CarsState(loading: true));

      try {
        final carModels = await _carsInteractor.getCars();
        if (carModels == null) {
          // TODO: add error handling
          throw Error();
        }
        emit(CarsState(carModels: carModels, completed: true));
      } catch (e) {
        emit(CarsState(error: e.toString()));
      }

    });
  }
}