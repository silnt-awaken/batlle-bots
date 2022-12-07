part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final Vector2? newPosition;
  final Vector2 severMovementPosition;
  const PlayerState({required this.severMovementPosition, this.newPosition});

  @override
  List<Object> get props => [severMovementPosition, newPosition ?? false];

  PlayerState copyWith(
      {Vector2? Function()? newPosition, Vector2? severMovementPosition}) {
    return PlayerState(
      severMovementPosition:
          severMovementPosition ?? this.severMovementPosition,
      newPosition: newPosition != null ? newPosition() : this.newPosition,
    );
  }
}
