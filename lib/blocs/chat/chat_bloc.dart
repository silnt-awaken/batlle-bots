import 'package:batlle_bots/models/chat.dart';
import 'package:batlle_bots/repositories/chat_repository.dart';
import 'package:batlle_bots/repositories/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(const ChatState(
          chats: [],
          currentText: '',
          chatStatus: ChatStatus.receiving,
          chatId: '',
        )) {
    final ChatRepository chatRepository = ChatRepository();
    on<ChatInitializeEvent>((event, emit) async {
      await emit.forEach<Chat>(chatRepository.chatStream, onData: (chat) {
        return state.copyWith(
          chats: [...state.chats, chat],
        );
      });
    });

    on<ChatSubmitEvent>((event, emit) {
      GameRepository.channel?.sink.add(
        event.message,
      );
      emit(state.copyWith(
        chatStatus: ChatStatus.submitted,
      ));
    });

    on<ChatUpdateTextEvent>((event, emit) {
      emit(state.copyWith(currentText: event.text));
    });

    on<ChatResetEvent>((event, emit) {
      emit(state.copyWith(
        currentText: '',
        chatStatus: ChatStatus.receiving,
      ));
    });
  }
}
