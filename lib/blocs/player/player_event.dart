part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class PlayerInitializeEvent extends PlayerEvent {}

class PlayerPositionChangedEvent extends PlayerEvent {
  final Vector2 newPosition;
  const PlayerPositionChangedEvent({required this.newPosition});

  @override
  List<Object> get props => [newPosition];
}
