import 'package:batlle_bots/app/views/game_view.dart';
import 'package:batlle_bots/blocs/game/game_bloc.dart';
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

  BattleBotsGame({required this.clientId, super.children});

  final String clientId;

  late final RouterComponent router;

  @override
  Color backgroundColor() => const Color.fromARGB(0, 125, 61, 61);

  @override
  Future<void>? onLoad() async {
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
    await add(FlameBlocProvider<GameBloc, GameState>.value(
      value: BlocProvider.of<GameBloc>(buildContext!),
      children: [router],
    ));
    super.onAttach();
  }
}
