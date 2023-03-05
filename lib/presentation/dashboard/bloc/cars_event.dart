part of 'cars_bloc.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();
}

class FetchCarsEvent extends CarsEvent {

  const FetchCarsEvent();

  @override
  List<Object?> get props => [];

}