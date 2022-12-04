import 'dart:developer';

import 'package:batlle_bots/models/client.dart';
import 'package:batlle_bots/repositories/game_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(clients: [])) {
    on<GameSetClient>((event, emit) async {
      await emit.forEach(GameRepository.clientStream, onData: (client) {
        log('client connected');
        return state.copyWith(client: () => client);
      });
    });
    on<GameGetPlayerCountEvent>((event, emit) async {
      await emit.forEach(GameRepository.clientsSubjectStream,
          onData: (clients) {
        log('there are ${clients.length} clients');
        final tempClients = List.of(clients);
        return state.copyWith(clients: tempClients);
      });
    });

    on<GameDeployClient>((event, emit) {
      emit(state.copyWith(
        client: () => state.client!.copyWith(isDeployed: true),
      ));
    });
  }
}
