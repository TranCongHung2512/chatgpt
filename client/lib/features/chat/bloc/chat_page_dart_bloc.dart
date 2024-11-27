import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/features/chat/models/chat_message_model.dart';
import 'package:client/features/chat/repos/chat_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'chat_page_dart_event.dart';
part 'chat_page_dart_state.dart';

class ChatPageDartBloc extends Bloc<ChatPageDartEvent, ChatPageDartState> {
  ChatPageDartBloc() : super(ChatPageDartInitial()) {
    on<ChatNewPromptEvent>(chatNewPromptEvent);
    on<ChatNewContentGeneratedEvent>(chatNewContentGeneratedEvent);
  }

  StreamSubscription<http.Response>? subscription;
  List<ChatMessageModel> cachedMessages = [];

  FutureOr<void> chatNewPromptEvent(
      ChatNewPromptEvent event, Emitter<ChatPageDartState> emit) {
    emit(ChatNewMessageGeneratingLoadingState());
    try {
      ChatMessageModel newMessage =
          ChatMessageModel(role: 'user', content: event.prompt);
      cachedMessages.add(newMessage);
      emit(ChatNewMessageGeneratedState());
      cachedMessages.add(ChatMessageModel(role: 'assistant', content: ""));
      subscription?.cancel();
      subscription = getChatGptResponseRepo(cachedMessages).listen((response) {
        for (String line in response.body.split('\n')) {
          String jsonDataString = line.replaceFirst("data: ", "");
          Map<String, dynamic> data = jsonDecode(jsonDataString.trim());
          add(ChatNewContentGeneratedEvent(content: data['data']));
        }
      });
    } catch (e) {
      log(e.toString());
      emit(ChatNewMessageGeneratingErrorState());
    }
  }

  FutureOr<void> chatNewContentGeneratedEvent(
      ChatNewContentGeneratedEvent event, Emitter<ChatPageDartState> emit) {
    ChatMessageModel modelMessage = cachedMessages.last;
    String content = event.content;
    cachedMessages.last = ChatMessageModel(
        role: 'assistant', content: modelMessage.content + content);
    log(cachedMessages.last.content);
    emit(ChatNewMessageGeneratedState());
  }
}
