import 'dart:developer';

import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/repositories/chat_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameRepository {
  static late final WebSocketChannel channel;

  final BehaviorSubject<String> messages = BehaviorSubject<String>();
  Stream<String> get messagesStream => messages.asBroadcastStream();

  void init() async {
    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://outside-server.herokuapp.com/ws'.removeHash()));

    channel.stream.listen((message) {
      if (message == GameUpdateType.playerJoined.value) {
      } else {
        log(message);
        ChatRepository.chats.add(Chat(text: message, sender: ''));
      }
    });
  }
}

enum GameUpdateType {
  playerJoined('Player Joined');

  final String value;
  const GameUpdateType(this.value);
}

extension on String {
  String removeHash() {
    return replaceAll('#', '');
  }
}
