// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarDto _$CarDtoFromJson(Map<String, dynamic> json) => CarDto(
      json['photo'] as String,
      DateTime.parse(json['deadline'] as String),
      json['priceStart'] as int,
      json['priceCurrent'] as int,
      json['mileage'] as int,
      $enumDecode(_$FuelTypeEnumMap, json['fuelType']),
      json['isModified'] as bool,
      json['valueModified'] as int?,
      AddressDto.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarDtoToJson(CarDto instance) => <String, dynamic>{
      'photo': instance.photo,
      'deadline': instance.deadline.toIso8601String(),
      'priceStart': instance.priceStart,
      'priceCurrent': instance.priceCurrent,
      'mileage': instance.mileage,
      'fuelType': _$FuelTypeEnumMap[instance.fuelType]!,
      'isModified': instance.isModified,
      'valueModified': instance.valueModified,
      'address': instance.address.toJson(),
    };

const _$FuelTypeEnumMap = {
  FuelType.gasoline: 'gasoline',
  FuelType.diesel: 'diesel',
  FuelType.hybrid: 'hybrid',
  FuelType.electric: 'electric',
};

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => AddressDto(
      json['street'] as String,
      json['zip'] as int,
      json['city'] as String,
    );

Map<String, dynamic> _$AddressDtoToJson(AddressDto instance) =>
    <String, dynamic>{
      'street': instance.street,
      'zip': instance.zip,
      'city': instance.city,
    };
