// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarDto _$CarDtoFromJson(Map<String, dynamic> json) => CarDto(
      (json['data'] as List<dynamic>)
          .map((e) => CarDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarDtoToJson(CarDto instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CarDataDto _$CarDataDtoFromJson(Map<String, dynamic> json) => CarDataDto(
      (json['id'] as num).toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$CarDataDtoToJson(CarDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
