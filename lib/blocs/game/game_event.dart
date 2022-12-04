part of 'game_bloc.dart';

abstract class GameEvent {
  const GameEvent();
}

class GameInitializeEvent extends GameEvent {}

class GameRemoveClient extends GameEvent {}

class GameGetPlayerCountEvent extends GameEvent {}

class GameDeployClient extends GameEvent {
  final Client client;
  const GameDeployClient({required this.client});
}

class GameSetClient extends GameEvent {}

class GameHandleDeployedState extends GameEvent {}
