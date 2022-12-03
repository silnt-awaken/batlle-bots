// todo: have a list of random colors and assign them to the bots

import 'package:uuid/uuid.dart';

class Client {
  late final String id;
  final bool isDeployed;

  Client({this.id = '', this.isDeployed = false}) {
    id = const Uuid().v4();
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client().copyWith(
      id: json['counter'],
    );
  }

  Client copyWith({String? id, bool? isDeployed}) {
    return Client(
      id: id ?? this.id,
      isDeployed: isDeployed ?? this.isDeployed,
    );
  }
}
