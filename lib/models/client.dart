// todo: have a list of random colors and assign them to the bots

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
