part of 'cars_bloc.dart';

class CarsState extends Equatable {
  final bool loading;
  final dynamic error;
  final bool completed;
  final List<CarModel>? carModels;

  const CarsState({
    this.loading = false,
    this.error,
    this.completed = false,
    this.carModels,
  });

  @override
  List<Object?> get props => [
    loading,
    error,
    completed,
    carModels,
  ];
}

class InitialCarsState extends CarsState {
  const InitialCarsState();

  @override
  List<Object> get props => <Object>[];
}