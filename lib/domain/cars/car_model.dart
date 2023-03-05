import 'package:equatable/equatable.dart';
import 'package:carbids/data/network/dto/car.dart';

class CarModel extends Equatable {
  final String photo;
  final DateTime deadline;
  final int priceStart;
  final int priceCurrent;
  final int mileage;
  final FuelType fuelType;
  final bool isModified;
  final int? valueModified;
  final CarModelAddress address;

  const CarModel(
      this.photo,
      this.deadline,
      this.priceStart,
      this.priceCurrent,
      this.mileage,
      this.fuelType,
      this.isModified,
      this.valueModified,
      this.address
      );

  @override
  List<Object?> get props => [
    photo,
    deadline,
    priceStart,
    priceCurrent,
    mileage,
    fuelType,
    isModified,
    valueModified,
    address,
  ];
}

class CarModelAddress {
  final String street;
  final int zip;
  final String city;

  const CarModelAddress(
      this.street,
      this.zip,
      this.city,
      );

  @override
  List<Object?> get props => [
    street,
    zip,
    city,
  ];
}