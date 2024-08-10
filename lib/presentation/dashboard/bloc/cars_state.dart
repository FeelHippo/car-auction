part of 'cars_bloc.dart';

class CarsState extends Equatable {

  const CarsState({
    this.loading = false,
    this.error,
    this.carsYears = const [],
    this.carsMakes = const [],
  });

  final bool loading;
  final dynamic error;
  final List<int> carsYears;
  final List<CarsModel> carsMakes;

  CarsState copyWith({
    bool? loading,
    dynamic error,
    List<int>? carsYears,
    List<CarsModel>? carsMakes,
  }) {
    return CarsState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      carsYears: carsYears ?? this.carsYears,
      carsMakes: carsMakes ?? this.carsMakes,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    error,
    carsYears,
    carsMakes,
  ];
}