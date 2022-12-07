import 'package:batlle_bots/app/views/game_view.dart';
import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/blocs/player/player_bloc.dart';
import 'package:batlle_bots/game/gameplay.dart';
import 'package:batlle_bots/game/world.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CameraType { primary }

class BattleBotsGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final BattleBotsWorld world;

  BattleBotsGame(
      {required this.clientId, super.children, required this.startPosition});

  final String clientId;
  final Vector2 startPosition;

  late final RouterComponent router;
  static late final Vector2 startPlayerPosition;

  @override
  Color backgroundColor() => const Color.fromARGB(0, 125, 61, 61);

  @override
  Future<void>? onLoad() async {
    startPlayerPosition = startPosition;
    router = RouterComponent(
      initialRoute: Gameplay.routeName,
      routes: {
        Gameplay.routeName: Route(() => Gameplay(children: GameView.players))
      },
    );
    await images.loadAll(<String>[
      'player.png',
      'arena.png',
    ]);

    final backgroundImage = Sprite(images.fromCache('arena.png'));
    add(
      SpriteComponent(
        sprite: backgroundImage,
        size: Vector2(785, 595),
        priority: -5,
      ),
    );
  }

  @override
  void onAttach() async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameBloc, GameState>.value(
            value: BlocProvider.of<GameBloc>(buildContext!),
          ),
          FlameBlocProvider<PlayerBloc, PlayerState>.value(
              value: BlocProvider.of<PlayerBloc>(buildContext!)),
        ],
        children: [router],
      ),
    );
    super.onAttach();
  }
}
