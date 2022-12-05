part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final Vector2 severMovementPosition;
  const PlayerState({required this.severMovementPosition});

  @override
  List<Object> get props => [severMovementPosition];
}
