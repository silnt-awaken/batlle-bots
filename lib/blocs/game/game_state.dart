part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<Client> clients;
  const GameState({required this.clients});

  @override
  List<Object> get props => [clients];

  GameState copyWith({
    List<Client>? clients,
  }) {
    return GameState(
      clients: clients ?? this.clients,
    );
  }
}
