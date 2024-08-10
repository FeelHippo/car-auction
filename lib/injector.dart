import 'package:carbids/domain/cars/cars_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:carbids/data/network/api/cars_provider_api_client.dart';
import 'package:carbids/domain/cars/cars_provider.dart';
import 'package:carbids/domain/cars/cars_interactor.dart';
import 'package:carbids/presentation/dashboard/bloc/cars_bloc.dart';

import 'package:carbids/modules/bloc_module.dart';
import 'package:carbids/modules/data_module.dart';
import 'package:carbids/modules/domain_module.dart';
import 'package:carbids/modules/network_module.dart';

/// Inversion of Control
class IOC {
  /// init all app dependencies
  IOC.appScope() : parent = null {
    _initDependencies();
  }

  /// same as appScope, for testing purposes
  IOC.appScopeTest({
    void Function(Injector injector)? builder,
  }) : parent = null {
    if (builder != null) {
      builder(injector);
    }
  }

  /// assembler, injects services to the application
  final Injector injector = Injector();
  final List<DisposableDependency> _disposables = <DisposableDependency>[];

  /// parent object passing in a child object's dependencies
  /// in addition to controlling execution flow
  final IOC? parent;

  void _initDependencies() {
    // API Clients
    _registerSingleton<Dio>(NetworkModule.createDio);
    _registerSingleton<CarsProviderApiClient>(NetworkModule.createCarsApiClient);
    // Data providers
    _registerDependency<CarsMapper>(DataModule.createCarsMapper);
    _registerSingleton<CarsProvider>(DataModule.createCarsProvider);
    // Interactors
    _registerSingleton<CarsInteractor>(DomainModule.createCarsInteractor);
    // Blocs
    _registerDependency<CarsBloc>(BlocModule.createCarsBloc);
  }

  void _registerSingleton<T>(
      DependencyBuilder<T> builder, {
        bool override = false,
        String dependencyName = '',
      }) {
    injector.registerSingleton<T>(
          () {
        final T instance = builder(injector);
        if (instance is DisposableDependency) {
          _disposables.add(instance);
        }
        return instance;
      },
      override: override,
      dependencyName: dependencyName,
    );
  }

  void _registerDependency<T>(
      DependencyBuilder<T> builder, {
        bool override = false,
        String dependencyName = '',
      }) {
    injector.registerDependency<T>(
          () {
        final T instance = builder(injector);
        if (instance is DisposableDependency) {
          _disposables.add(instance);
        }
        return instance;
      },
      override: override,
      dependencyName: dependencyName,
    );
  }

  /// return instance of dependency object
  T getDependency<T>({String dependencyName = ''}) {
    try {
      if (exists<T>()) {
        return injector.get<T>(dependencyName: dependencyName);
      } else if (parent?.exists<T>() ?? false) {
        return parent!.getDependency<T>(dependencyName: dependencyName);
      } else {
        debugPrint('Type not defined $T');
        throw Error();
      }
    } catch (e) {
      debugPrint('Type not defined $T');
      rethrow;
    }
  }

  /// returns True if instance of dependency exists
  bool exists<T>({String dependencyName = ''}) {
    return injector.exists<T>(dependencyName: dependencyName);
  }

  /// dispose of a dependency
  void dispose() {
    for (final DisposableDependency disposable in _disposables) {
      disposable.dispose();
    }
  }
}

typedef DependencyBuilder<T> = T Function(Injector injector);

// ignore: one_member_abstracts
abstract class DisposableDependency {
  void dispose();
}