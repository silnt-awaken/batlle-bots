import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/repositories/chat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState(chats: [])) {
    final ChatRepository chatRepository = ChatRepository();
    on<ChatInitializeEvent>((event, emit) async {
      await emit.forEach(chatRepository.chatStream, onData: (chat) {
        return state.copyWith(chats: [...state.chats, chat]);
      });
    });
  }
}
