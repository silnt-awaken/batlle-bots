class Chat {
  final String text;
  final String sender;

  const Chat({required this.text, required this.sender});

  // from json
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      text: json['message'],
      sender: json['sender'],
    );
  }
}
