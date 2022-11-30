part of 'game_bloc.dart';

abstract class GameEvent {
  const GameEvent();
}

class GameInitializeEvent extends GameEvent {}

class GameRemoveClient extends GameEvent {}

class GameGetPlayerCountEvent extends GameEvent {}
