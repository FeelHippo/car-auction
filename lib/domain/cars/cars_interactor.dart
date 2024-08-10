import 'package:carbids/domain/cars/cars_model.dart';
import 'package:carbids/domain/cars/cars_provider.dart';

class CarsInteractor {
  final CarsProvider _carsProvider;

  CarsInteractor(this._carsProvider);

  Future<List<int>> getYears({
    String? year,
    String? make,
    String? model,
  }) async {
    return _carsProvider.getYears(year, make, model);
  }

  Future<List<CarsModel>> getMakes({
    String? year,
    String? make,
  }) async {
    return _carsProvider.getMakes(year, make);
  }

}