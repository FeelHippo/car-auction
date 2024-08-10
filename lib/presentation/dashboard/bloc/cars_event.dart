part of 'cars_bloc.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();
}

class FetchCarsByYearsEvent extends CarsEvent {

  const FetchCarsByYearsEvent({
    this.year,
    this.make,
    this.model,
  });

  final String? year;
  final String? make;
  final String? model;

  @override
  List<Object?> get props => <Object?>[year, make, model];

}

class FetchCarsByMakesEvent extends CarsEvent {

  const FetchCarsByMakesEvent({
    this.year,
    this.make,
  });

  final String? year;
  final String? make;

  @override
  List<Object?> get props => <Object?>[year, make];

}