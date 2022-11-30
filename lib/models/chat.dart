import 'dart:math';

import 'package:flutter/material.dart';

class Chat {
  final String text;
  final String sender;
  final Color color;

  const Chat({required this.text, required this.sender, required this.color});

  // from json
  factory Chat.fromJson(Map<String, dynamic> json) {
    if (!clientColorMap.containsKey(json['sender'])) {
      clientColorMap.addAll({
        json['sender']: randomColors[Random().nextInt(randomColors.length)]
      });
    }
    return Chat(
        text: json['message'],
        sender: json['sender'],
        color: clientColorMap[json['sender']]!);
  }
}

final clientColorMap = <String, Color>{};

final randomColors = [
  const Color(0xFFE57373),
  const Color(0xFFBA68C8),
  const Color(0xFF7986CB),
  const Color(0xFF4FC3F7),
  const Color(0xFF4DD0E1),
  const Color(0xFF81C784),
  const Color(0xFFFFD54F),
  const Color(0xFFFFB74D),
  const Color(0xFFA1887F),
  const Color(0xFF90A4AE),
  const Color(0xFFE0E0E0),
  const Color(0xFFAED581),
  const Color(0xFF9575CD),
  const Color(0xFF64B5F6),
  const Color(0xFF4DB6AC),
  const Color(0xFF81C784),
  const Color(0xFFFF8A65),
  const Color(0xFFDCE775),
  const Color(0xFFFFD54F),
  const Color(0xFFFFB74D),
  const Color(0xFFA1887F),
  const Color(0xFF90A4AE),
  const Color(0xFFE0E0E0),
  const Color(0xFFAED581),
  const Color(0xFF9575CD),
  const Color(0xFF64B5F6),
];
