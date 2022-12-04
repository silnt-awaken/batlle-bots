import 'package:flame/experimental.dart';

class BattleBotsWorld extends World {
  // we need to see if there is a new state when the game has new clients

  BattleBotsWorld({super.children, required this.clientId});

  final String clientId;
}
