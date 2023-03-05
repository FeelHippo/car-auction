import 'package:injector/injector.dart';
import 'package:dio/dio.dart';

import 'package:carbids/modules/app_module.dart';
import 'package:carbids/modules/bloc_module.dart';
import 'package:carbids/modules/data_module.dart';
import 'package:carbids/modules/domain_module.dart';
import 'package:carbids/modules/network_module.dart';

class IOC {
  final Injector injector = Injector();
  final List<DisposableDependency> _disposables = [];
  final IOC? parent;

  IOC.appScope() : parent = null {
    _initDependencies();
  }

  IOC.appScopeTest(
      {void Function(Injector injector)? builder}
  ) : parent = null {
    if (builder != null) {
      builder(injector);
    }
  }

  void _initDependencies() {
    // Common
    _registerSingleton<Dio>(NetworkModule.createDio);
    // Cars
    _registerSingleton<CarsApiClient>(NetworkModule.createCarsApiClient);
    _registerSingleton<CarsProvider>(DataModule.createCarsProvider);
    _registerSingleton<CarsInteractor>(DomainModule.createCarsInteractor);
    _registerDependency<CarsBloc>(BlocModule.createCarsBloc);
  }

  void _registerSingleton<T>(Builder<T> builder, {bool override = false, String dependencyName = ""}) {
    injector.registerSingleton<T>(() {
      final instance = builder(injector);
      if (instance is DisposableDependency) {
        _disposables.add(instance);
      }
      return instance;
    }, override: override, dependencyName: dependencyName);
  }

  // ignore: unused_element
  void _registerDependency<T>(Builder<T> builder, {bool override = false, String dependencyName = ""}) {
    injector.registerDependency<T>((){
      final instance = builder(injector);
      if (instance is DisposableDependency) {
        _disposables.add(instance);
      }
      return instance;
    }, override: override, dependencyName: dependencyName);
  }

  T getDependency<T>({String dependencyName = ""}) {
    try {
      if (exists<T>()) {
        return injector.get<T>(dependencyName: dependencyName);
      } else if (parent?.exists() ?? false) {
        return parent!.getDependency<T>(dependencyName: dependencyName);
      } else {
        throw 'Type not defined ${T.toString()}';
      }
    } catch (e) {
      throw 'Type not defined ${T.toString()}';
    }
  }

  bool exists<T>({String dependencyName = ""}) {
    return injector.exists<T>(dependencyName: dependencyName);
  }

  void dispose() {
    for (final disposable in _disposables) {
      disposable.dispose();
    }
  }
}

typedef Builder<T> = T Function(Injector injector);

// ignore: one_member_abstracts
abstract class DisposableDependency {
  void dispose();
}