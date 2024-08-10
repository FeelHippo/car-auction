import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:carbids/data/network/dto/car.dart';

part 'cars_provider_api_client.g.dart';

@RestApi()
abstract class CarsProviderApiClient {
  factory CarsProviderApiClient(Dio dio) = _CarsProviderApiClient;

  @GET('api/years')
  Future<List<int>> getYears(
      @Query('year') String? year,
      @Query('make') String? make,
      @Query('model') String? model,
  );

  @GET('api/makes')
  Future<CarDto> getMakes(
      @Query('year') String? year,
      @Query('make') String? make,
  );

}