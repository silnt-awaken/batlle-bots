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

  static final BehaviorSubject<Client> leavingClients =
      BehaviorSubject<Client>();

  static Stream<Client> get leavingClientStream =>
      leavingClients.asBroadcastStream();

  static final BehaviorSubject<Client> clients = BehaviorSubject<Client>();
  static Stream<Client> get clientStream => clients.asBroadcastStream();

  void init() {
    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://outside-server.herokuapp.com/ws'),
        pingInterval: const Duration(minutes: 1));

    channel?.stream.listen((message) {
      if (message.contains('connected')) {
        final convertString = message.replaceAll(',"type":"connected"', '');
        final client = Client.fromJson(jsonDecode(convertString));
        clients.add(client);
        return;
      }

      if (message.contains('disconnected')) {
        final convertString = message.replaceAll(',"type":"disconnected"', '');
        final client = Client.fromJson(jsonDecode(convertString));
        leavingClients.add(client);
        return;
      }

      ChatRepository.chats.add(Chat.fromJson(jsonDecode(message)));
    });
  }

  Future<void> close() async {
    await channel?.sink.close() ?? log('channel is null');
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
