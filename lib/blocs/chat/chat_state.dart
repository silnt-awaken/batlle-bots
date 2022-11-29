part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<Chat> chats;
  final String currentText;
  final ChatStatus chatStatus;
  final String chatId;
  const ChatState({
    required this.chats,
    required this.currentText,
    required this.chatStatus,
    required this.chatId,
  });

  @override
  List<Object> get props => [chats, currentText, chatStatus, chatId];

  ChatState copyWith({
    List<Chat>? chats,
    String? currentText,
    ChatStatus? chatStatus,
    String? chatId,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      currentText: currentText ?? this.currentText,
      chatStatus: chatStatus ?? this.chatStatus,
      chatId: chatId ?? this.chatId,
    );
  }
}

enum ChatStatus {
  receiving,
  submitted,
}
