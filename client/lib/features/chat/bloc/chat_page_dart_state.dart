part of 'chat_page_dart_bloc.dart';

@immutable
sealed class ChatPageDartState {}

final class ChatPageDartInitial extends ChatPageDartState {}

class ChatNewMessageGeneratingLoadingState extends ChatPageDartState {}

class ChatNewMessageGeneratingErrorState extends ChatPageDartState {}

class ChatNewMessageGeneratedState extends ChatPageDartState {}
