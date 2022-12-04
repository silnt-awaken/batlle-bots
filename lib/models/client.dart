// todo: have a list of random colors and assign them to the bots

import 'package:flame/components.dart';

class Client {
  final String id;
  final bool isDeployed;
  final Vector2 position;

  Client({
    required this.id,
    this.isDeployed = false,
    required this.position,
  });

  Client copyWith({String? id, bool? isDeployed}) {
    return Client(
      id: id ?? this.id,
      isDeployed: isDeployed ?? this.isDeployed,
      position: position,
    );
  }
}
