import 'package:batlle_bots/models/client.dart';
import 'package:batlle_bots/repositories/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(clients: [])) {
    on<GameInitializeEvent>((event, emit) async {
      final List<Client> clientList = [];
      await emit.forEach<Client>(GameRepository.clientStream, onData: (client) {
        clientList.add(client);
        return state.copyWith(
          clients: clientList,
        );
      });
    });

    on<GameRemoveClient>((event, emit) async {
      await emit.forEach(GameRepository.leavingClientStream, onData: (data) {
        final clientList = List.of(state.clients);
        clientList.removeWhere((client) => client.id == data.id);
        return state.copyWith(
          clients: clientList,
        );
      });
    });
  }
}
