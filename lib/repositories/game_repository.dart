import 'dart:convert';
import 'dart:developer';

import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/models/client.dart';
import 'package:batlle_bots/repositories/chat_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameRepository {
  static WebSocketChannel? channel;

  static final BehaviorSubject<Client> clients = BehaviorSubject<Client>();
  static Stream<Client> get clientStream => clients.asBroadcastStream();

  void init() {
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://localhost:8080/ws'.removeHash()),
        pingInterval: const Duration(minutes: 1));

    channel?.stream.listen((message) {
      if ((message as String).contains('User joined')) {
        final convertString =
            message.replaceAll(',"message":"User joined"', '');
        final client = Client.fromJson(jsonDecode(convertString));
        clients.add(client);

        //clients.add(Client.fromJson(jsonDecode(convertString)));
        return;
      }
      if ((message).contains('userId')) {
        final client = Client.fromJson(jsonDecode(message));
        clients.add(client);
        return;
      }
      if (message == GameUpdateType.playerJoined.value) {
        return;
      } else {
        ChatRepository.chats.add(Chat.fromJson(jsonDecode(message)));
      }
    });
  }

  void close() {
    channel?.sink.close() ?? log('channel is null');
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
