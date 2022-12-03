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

  static final ReplaySubject<List<Client>> _clientsSubject =
      ReplaySubject<List<Client>>();

  static Stream<List<Client>> get clientsSubjectStream =>
      _clientsSubject.asBroadcastStream();

  void init() {
    channel = IOWebSocketChannel.connect(
      Uri.parse('wss://outside-server.herokuapp.com/ws'),
      pingInterval: const Duration(minutes: 5),
    );

    var clientList = <Client>[];

    channel?.stream.listen(
      (data) async {
        if (data is String) {
          ChatRepository.chats.add(Chat.fromJson(jsonDecode(data)));
        } else {
          final json = jsonDecode(String.fromCharCodes(data));

          switch (json['type']) {
            case 'joined':
            case 'closed':
              clientList.clear();

              json['clients'].forEach((client) {
                clientList.add(Client(id: client.toString()));
              });

              _clientsSubject.add(clientList);
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
