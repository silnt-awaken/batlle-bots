import 'dart:developer';

import 'package:flame/components.dart';

// A base class for everything that lives inside the game world.
class Entity extends PositionComponent {
  Entity({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
  }) : id = _idCount++ {
    log('Created $debugName:$id', level: _infoLogLevel);
  }

  // An ever increasing counter.
  static int _idCount = 0;

  static const _infoLogLevel = 800;

  // An auto-assigned unique identifier.
  final int id;

  // A debug name for this entity.
  String get debugName => toString();

  @override
  Future<void>? onLoad() {
    // Note: FlameBlocProvider cuts away call to this method.
    log('Loaded $debugName:$id', level: _infoLogLevel);
    return super.onLoad();
  }

  @override
  void onMount() {
    log('Mounted $debugName:$id to $parent', level: _infoLogLevel);
    super.onMount();
  }

  @override
  void onRemove() {
    log('Removed $debugName:$id from $parent', level: _infoLogLevel);
    super.onRemove();
  }
}
