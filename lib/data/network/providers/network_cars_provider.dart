import 'package:carbids/data/network/api/cars_provider_api_client.dart';
import 'package:carbids/domain/cars/cars_mapper.dart';
import 'package:carbids/domain/cars/cars_model.dart';
import 'package:carbids/domain/cars/cars_provider.dart';

class NetworkCarsProvider extends CarsProvider {
  NetworkCarsProvider(this.carsProviderApiClient, this._mapper);
  final CarsProviderApiClient carsProviderApiClient;
  final CarsMapper _mapper;

  @override
  Future<List<int>> getYears(
    String? year,
    String? make,
    String? model,
  ) async {
    return carsProviderApiClient.getYears(year, make, model);
  }

  @override
  Future<List<CarsModel>> getMakes(
    String? year,
    String? make,
  ) async {
    final response = await carsProviderApiClient.getMakes(year, make);
    return response.data.map(_mapper.map).toList();
  }
}