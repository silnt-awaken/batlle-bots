import 'package:batlle_bots/repositories/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    final GameRepository gameRepository = GameRepository();

    on<GameInitializeEvent>((event, emit) {
      gameRepository.init();
    });
  }
}
