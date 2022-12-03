import 'dart:developer';

import 'package:batlle_bots/models/client.dart';
import 'package:batlle_bots/repositories/game_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(clients: [])) {
    on<GameGetPlayerCountEvent>((event, emit) async {
      await emit.forEach(GameRepository.clientsSubjectStream,
          onData: (clients) {
        log('there are ${clients.length} clients');
        return state.copyWith(clients: clients);
      });
    });
  }
}
