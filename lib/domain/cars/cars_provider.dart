import 'package:carbids/domain/cars/car_model.dart';

abstract class CarsProvider {
  Future<List<CarModel>?> getCars();
}