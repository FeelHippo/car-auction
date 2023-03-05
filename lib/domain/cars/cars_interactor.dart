import 'package:carbids/domain/cars/car_model.dart';
import 'package:carbids/domain/cars/cars_provider.dart';

class CarsInteractor {
  final CarsProvider _carsProvider;

  CarsInteractor(this._carsProvider);

  Future<List<CarModel>?> getCars() async {
    return _carsProvider.getCars();
  }
}