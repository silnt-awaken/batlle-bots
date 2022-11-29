part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<Chat> chats;
  const ChatState({required this.chats});

  @override
  List<Object> get props => [chats];

  ChatState copyWith({List<Chat>? chats}) {
    return ChatState(chats: chats ?? this.chats);
  }
}
