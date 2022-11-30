import 'package:batlle_bots/models/chat.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  static final BehaviorSubject<Chat> chats = BehaviorSubject<Chat>();
  Stream<Chat> get chatStream => chats.asBroadcastStream();
}
