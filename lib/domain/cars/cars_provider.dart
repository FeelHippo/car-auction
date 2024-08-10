import 'package:carbids/domain/cars/cars_model.dart';

abstract class CarsProvider {
  Future<List<int>> getYears(
    String? year,
    String? make,
    String? model,
  );
  Future<List<CarsModel>> getMakes(
    String? year,
    String? make,
  );
}