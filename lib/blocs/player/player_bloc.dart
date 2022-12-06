import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/repositories_barrel.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc()
      : super(PlayerState(
            severMovementPosition: Vector2.zero(),
            newPosition: Vector2.zero())) {
    final PlayerRepository playerRepository = PlayerRepository();
    on<PlayerInitializeEvent>((event, emit) async {
      await emit.forEach(playerRepository.positionStream, onData: (data) {
        return state.copyWith(severMovementPosition: data);
      });
    });

    on<PlayerPositionChangedEvent>(((event, emit) {
      emit(state.copyWith(newPosition: event.newPosition));
    }));
  }
}
