import 'dart:convert';
import 'dart:math';

import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/models/client.dart';
import 'package:flame/components.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'chat_repository.dart';

class GameRepository {
  static WebSocketChannel? channel;

  static final BehaviorSubject<Client> clientSubject =
      BehaviorSubject<Client>();

  static Stream<Client> get clientStream => clientSubject.stream;

  static final BehaviorSubject<List<Client>> _clientsSubject =
      BehaviorSubject<List<Client>>();

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

          if (json['selected_client'] != null) {
            clientSubject.add(
                Client(id: json['selected_client'], position: Vector2.zero()));
          }

          switch (json['type']) {
            case 'deploy':
              clientList[clientList
                      .indexWhere((client) => client.id == json['client'])] =
                  clientList[clientList
                          .indexWhere((client) => client.id == json['client'])]
                      .copyWith(
                isDeployed: true,
                position: Vector2(
                  Random().nextInt(200).toDouble(),
                  Random().nextInt(200).toDouble(),
                ),
              );
              _clientsSubject.add(clientList);
              break;
            case 'joined':
            case 'closed':
              final mapOfClientProperties = <String, Vector2>{};
              clientList
                  .where((client) =>
                      json['clients'].contains(int.parse(client.id)))
                  .where((client) => client.isDeployed)
                  .map((client) =>
                      mapOfClientProperties[client.id] = client.position)
                  .toList();

              clientList.clear();

              json['clients'].forEach((client) {
                clientList.add(
                  Client(
                    id: client.toString(),
                    position: Vector2.zero(),
                  ),
                );
              });

              for (var props in mapOfClientProperties.entries) {
                final index =
                    clientList.indexWhere((client) => client.id == props.key);
                clientList[index] = clientList[index].copyWith(
                  isDeployed: true,
                  position: props.value,
                );
              }

              _clientsSubject.add(clientList);
              break;
            default:
              break;
          }
        }
      },
    );
  }

  Future<void> close() async {
    await channel?.sink.close() ?? print('channel is null');
  }
}
