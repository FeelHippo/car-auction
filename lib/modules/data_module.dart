import 'package:carbids/data/network/providers/network_cars_provider.dart';
import 'package:carbids/domain/cars/cars_mapper.dart';
import 'package:carbids/domain/cars/cars_provider.dart';
import 'package:carbids/data/network/api/cars_provider_api_client.dart';
import 'package:injector/injector.dart';

class DataModule{
  static CarsMapper createCarsMapper(Injector injector) =>
    CarsMapper();
  static CarsProvider createCarsProvider(Injector injector) =>
      NetworkCarsProvider(
          injector.get<CarsProviderApiClient>(),
          injector.get<CarsMapper>(),
      );
}