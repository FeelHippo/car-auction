import 'package:equatable/equatable.dart';

class CarsModel extends Equatable {
  const CarsModel(this.id, this.name);
  final int id;
  final String name;

  @override
  List<Object?> get props => <Object?>[id, name];

}