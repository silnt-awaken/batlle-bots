import 'package:flame/components.dart';
import 'package:rxdart/rxdart.dart';

class PlayerRepository {
  static final BehaviorSubject<Vector2> positionSubject =
      BehaviorSubject<Vector2>();
  Stream<Vector2> get positionStream => positionSubject.asBroadcastStream();
}
