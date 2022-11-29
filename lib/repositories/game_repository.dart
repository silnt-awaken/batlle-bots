import 'dart:convert';
import 'dart:developer';

import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/repositories/chat_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameRepository {
  static WebSocketChannel? channel;

  final BehaviorSubject<Client> clients = BehaviorSubject<Client>();
  Stream<Client> get clientStream => clients.asBroadcastStream();

  void init() {
    channel = IOWebSocketChannel.connect(
        Uri.parse('wss://outside-server.herokuapp.com/ws'.removeHash()),
        pingInterval: const Duration(minutes: 1));

    channel?.stream.listen((message) {
      if ((message as String).contains('user joined')) {
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

class Client {
  final String id;

  Client({required this.id});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(id: json['userId'].toString());
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Client(id: $id)';
  }
}
