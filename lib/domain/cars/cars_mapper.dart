import 'package:carbids/data/network/dto/car.dart';
import 'package:carbids/domain/cars/cars_model.dart';

class CarsMapper {
  CarsMapper();

  CarsModel map(CarDataDto dto) {
    return CarsModel(dto.id, dto.name);
  }
}