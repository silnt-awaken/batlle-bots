import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';

class Client extends Equatable {
  final String id;
  final bool isDeployed;
  final Vector2 position;
  final Vector2 movement;

  const Client({
    required this.id,
    this.isDeployed = false,
    required this.position,
    required this.movement,
  });

  Client copyWith(
      {String? id, bool? isDeployed, Vector2? position, Vector2? movement}) {
    return Client(
      id: id ?? this.id,
      isDeployed: isDeployed ?? this.isDeployed,
      position: position ?? this.position,
      movement: movement ?? this.movement,
    );
  }

  @override
  List<Object?> get props => [id, isDeployed, position];
}
