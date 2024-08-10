import 'package:bloc/bloc.dart';
import 'package:carbids/domain/cars/cars_model.dart';
import 'package:equatable/equatable.dart';
import 'package:carbids/domain/cars/cars_interactor.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final CarsInteractor _carsInteractor;

  CarsBloc(this._carsInteractor) : super(const CarsState()) {
    on<FetchCarsByYearsEvent>((event, emit) async {

      emit(state.copyWith(loading: true));

      try {
        final List<int> carsYears = await _carsInteractor.getYears(
          year: event.year,
          make:  event.make,
          model:  event.model,
        );
        emit(
            state.copyWith(
              carsMakes: [],
              carsYears: carsYears,
              loading: false,
            ),
        );
      } catch (e) {
        emit(CarsState(error: e.toString()));
      }

    });
    on<FetchCarsByMakesEvent>((event, emit) async {

      emit(state.copyWith(loading: true));

      try {
        final List<CarsModel> carsMakes = await _carsInteractor.getMakes(
          year: event.year,
          make: event.make,
        );
        emit(
          state.copyWith(
            carsMakes: carsMakes,
            carsYears: event.year != null
              ? [int.parse(event.year!)]
              : [],
            loading: false,
          ),
        );
      } catch (e) {
        emit(CarsState(error: e.toString()));
      }
    });
  }
}