// todo: have a list of random colors and assign them to the bots

class Client {
  final String id;
  final bool isDeployed;

  Client({required this.id, this.isDeployed = false});

  Client copyWith({String? id, bool? isDeployed}) {
    return Client(
      id: id ?? this.id,
      isDeployed: isDeployed ?? this.isDeployed,
    );
  }
}
