import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable(explicitToJson: true)
class CarDto {
  final List<CarDataDto> data;

  CarDto(this.data);

  factory CarDto.fromJson(Map<String, dynamic> json) => _$CarDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CarDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CarDataDto {
  final int id;
  final String name;

  CarDataDto(
    this.id,
    this.name,
  );

  factory CarDataDto.fromJson(Map<String, dynamic> json) => _$CarDataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CarDataDtoToJson(this);
}