import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable(explicitToJson: true)
class CarDto {
  final String photo;
  final DateTime deadline;
  final int priceStart;
  final int priceCurrent;
  final int mileage;
  final FuelType fuelType;
  final bool isModified;
  final int? valueModified;
  final AddressDto address;

  CarDto(
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

  factory CarDto.fromJson(Map<String, dynamic> json) => _$CarDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CarDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressDto {
  final String street;
  final int zip;
  final String city;

  AddressDto(
    this.street,
    this.zip,
    this.city,
  );

  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}

enum FuelType {
  gasoline,
  diesel,
  hybrid,
  electric,
}