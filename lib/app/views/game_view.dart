import 'package:batlle_bots/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget.controlled(gameFactory: () => BattleBotsGame()));
  }
}
