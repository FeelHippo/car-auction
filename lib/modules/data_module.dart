import 'package:carbids/domain/cars/cars_provider.dart';
import 'package:carbids/domain/cars/network_cars_provider.dart';
import 'package:carbids/data/network/cars_provider_api_client.dart';
import 'package:injector/injector.dart';

class DataModule{
  static CarsProviderMapper createCarsProviderMapper(Injector injector) => CarsProviderMapper();
  static CarsProvider createCarsProvider(Injector injector) => NetworkClassProvider(
      injector.get<CarsProviderApiClient>(),
      injector.get<CarsProviderMapper>(),
  );
}