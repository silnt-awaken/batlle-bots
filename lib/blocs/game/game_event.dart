part of 'game_bloc.dart';

abstract class GameEvent {
  const GameEvent();
}

class GameInitializeEvent extends GameEvent {}

class GameRemoveClient extends GameEvent {
  const GameRemoveClient(this.client);
  final Client client;
}
