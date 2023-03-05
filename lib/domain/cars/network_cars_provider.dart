import 'package:carbids/domain/cars/cars_provider.dart';
import 'package:carbids/data/network/cars_provider_api_client.dart';
import 'package:carbids/domain/cars/car_model.dart';
import 'package:carbids/data/network/dto/car.dart';

class NetworkClassProvider extends CarsProvider {
  final CarsProviderApiClient _apiClient;
  final CarsProviderMapper _mapper;

  NetworkClassProvider(this._apiClient, this._mapper);

  @override
  Future<List<CarModel>?> getCars() async {
    final response = _apiClient.getCars();
    return response.map((car) => _mapper.map(car)).toList();
  }
}

class CarsProviderMapper {
  CarsProviderMapper();

  CarModel map(CarDto dto) {
    return CarModel(
        dto.photo,
        dto.deadline,
        dto.priceStart,
        dto.priceCurrent,
        dto.mileage,
        dto.fuelType,
        dto.isModified,
        dto.valueModified,
        CarModelAddress(
            dto.address.street,
            dto.address.zip,
            dto.address.city,
        ),
    );
  }
}