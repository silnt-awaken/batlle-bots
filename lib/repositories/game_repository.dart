import 'dart:convert';
import 'dart:developer';

import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/models/client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'chat_repository.dart';

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
      Uri.parse('ws://localhost:8080/ws'),
    );

    channel?.stream.listen(
      (data) {
        if (data is String) {
          ChatRepository.chats.add(Chat.fromJson(jsonDecode(data)));
        } else {
          final json = jsonDecode(String.fromCharCodes(data));

          switch (json['type']) {
            case 'joined':
              clients.add(Client.fromJson(json));
              break;
            case 'closed':
              leavingClients.add(Client.fromJson(json));
              break;
            default:
              log('Unknown message type');
          }
        }
      },
    );
  }

  Future<void> close() async {
    await channel?.sink.close() ?? log('channel is null');
  }
}

// for reference

var codes = [
  0, // idle
  1, // connected peer
  2, // disconnected peer
  3, // message
];
