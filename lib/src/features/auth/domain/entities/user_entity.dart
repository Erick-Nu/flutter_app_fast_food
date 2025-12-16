import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final int points;
  final String levelName; // Aquí guardaremos "Pizza Love", "Novato", etc.

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.points,
    this.levelName = 'Novato',
  });

  @override
  List<Object?> get props => [id, email, name, points, levelName];
}