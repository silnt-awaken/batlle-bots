part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<Client> clients;
  final Client? client;
  const GameState({required this.clients, this.client});

  @override
  List<Object> get props => [clients, client ?? false];

  GameState copyWith({
    List<Client>? clients,
    Client? Function()? client,
  }) {
    return GameState(
      clients: clients ?? this.clients,
      client: client != null ? client() : this.client,
    );
  }
}
