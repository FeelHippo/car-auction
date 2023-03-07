import 'package:carbids/domain/cars/cars_interactor.dart';
import 'package:carbids/domain/cars/cars_provider.dart';
import 'package:injector/injector.dart';

class DomainModule {
  static CarsInteractor createCarsInteractor(Injector injector) => CarsInteractor(injector.get<CarsProvider>());
}