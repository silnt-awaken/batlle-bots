part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<Client> clients;
  final Client? client;
  final GameStatus status;
  const GameState({required this.clients, this.client, required this.status});

  @override
  List<Object> get props => [clients, client ?? false, status];

  GameState copyWith({
    List<Client>? clients,
    Client? Function()? client,
    GameStatus? status,
  }) {
    return GameState(
      clients: clients ?? this.clients,
      client: client != null ? client() : this.client,
      status: status ?? this.status,
    );
  }
}

enum GameStatus {
  idle,
  deploying,
}
