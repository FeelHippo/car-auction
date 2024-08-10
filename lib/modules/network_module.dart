import 'package:carbids/data/network/api/cars_provider_api_client.dart';
import 'package:carbids/data/network/dio/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static Dio createDio(Injector injector) {
    return DioFactory.create();
  }
  static CarsProviderApiClient createCarsApiClient(Injector injector) =>
      CarsProviderApiClient(
        injector.get<Dio>(),
      );
}