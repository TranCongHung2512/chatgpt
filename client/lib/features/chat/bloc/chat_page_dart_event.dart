part of 'chat_page_dart_bloc.dart';

@immutable
sealed class ChatPageDartEvent {}

class ChatNewPromptEvent extends ChatPageDartEvent {
  final String prompt;
  ChatNewPromptEvent({
    required this.prompt,
  });
}

class ChatNewContentGeneratedEvent extends ChatPageDartEvent {
  final String content;

  ChatNewContentGeneratedEvent({
    required this.content,
  });
}
