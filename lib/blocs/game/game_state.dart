part of 'game_bloc.dart';

class GameState extends Equatable {
  final int clientCounter;
  const GameState({required this.clientCounter});

  @override
  List<Object> get props => [clientCounter];

  GameState copyWith({
    int? clientCounter,
  }) {
    return GameState(
      clientCounter: clientCounter ?? this.clientCounter,
    );
  }
}
