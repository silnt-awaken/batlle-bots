part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatInitializeEvent extends ChatEvent {}

class ChatUpdateTextEvent extends ChatEvent {
  final String text;
  const ChatUpdateTextEvent({required this.text});

  @override
  List<Object> get props => [text];
}

class ChatSubmitEvent extends ChatEvent {
  final String message;
  const ChatSubmitEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatResetEvent extends ChatEvent {}
