import 'dart:convert';
import 'dart:developer';

import 'package:batlle_bots/models/client.dart';
import 'package:batlle_bots/repositories/game_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(clients: [], status: GameStatus.idle)) {
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
      GameRepository.channel!.sink.add(json.encode({
        'type': 'deploy',
        'client': event.client.id,
      }).codeUnits);
      final clients = List.of(state.clients);
      final client =
          clients.firstWhere((client) => client.id == event.client.id);
      clients[clients.indexOf(client)] =
          client.copyWith(isDeployed: !client.isDeployed);
      emit(state.copyWith(status: GameStatus.deploying));
    });

    on<GameHandleDeployedState>((event, emit) {
      emit(state.copyWith(status: GameStatus.idle));
    });

    on<GameToggleDeployedForClient>((event, emit) {
      final clients = List.of(state.clients);
      final client =
          clients.firstWhere((client) => client.id == event.clientId);
      clients[clients.indexOf(client)] =
          client.copyWith(isDeployed: !client.isDeployed);
      emit(state.copyWith(clients: clients));
    });
  }
}
