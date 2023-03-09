import 'package:carbids/data/network/cars_provider_api_client.dart';
import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static CarsProviderApiClient createCarsApiClient(Injector injector) => CarsProviderApiClient(injector.get<Dio>());
}