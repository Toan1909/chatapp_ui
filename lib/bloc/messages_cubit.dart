import 'dart:async';
import 'dart:convert';

import 'package:chatapp/models/convers_model.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/response_ws_model.dart';
import 'package:chatapp/network/websocket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/app_api.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final Map<String, List<Message>> messages;
  MessagesLoaded(this.messages);
}

class MessagesError extends MessagesState {
  String message;
  MessagesError(this.message);
}

class MessagesCubit extends Cubit<MessagesState> {
  // Singleton Instance
  static final MessagesCubit _instance = MessagesCubit._internal();

  // Constructor private để ngăn khởi tạo lại.
  MessagesCubit._internal() : super(MessagesInitial());

  // Factory để trả về instance duy nhất.
  factory MessagesCubit(List<Conversation> conversations) {
    _instance._initialize(conversations);
    return _instance;
  }

  List<Conversation> conversations = [];
  late final Map<String, List<Message>> _currentMapMessages = {};
  StreamSubscription? _subscription;

  // Phương thức để khởi tạo lại khi cần thiết
  void _initialize(List<Conversation> convs) {
    this.conversations = convs;
    _listenToStream(conversations);
  }

  Future<void> _listenToStream(List<Conversation> conversations) async {
    // Hủy stream cũ nếu tồn tại
    if (_subscription != null) {
      await _subscription?.cancel();
    }

    _subscription = WebSocketService().stream().listen((data) {
      if (data.type == ResponseWsType.newMessage) {
        Message newMes = Message.fromJson(data.data);
        print("======Tin nhan moi :${newMes.content}======");
        if (_currentMapMessages.containsKey(newMes.conversationId)) {
          _currentMapMessages[newMes.conversationId]!.insert(0, newMes);
        } else {
          _currentMapMessages[newMes.conversationId!] = [newMes];
        }
        emit(MessagesLoaded(_currentMapMessages));
      }
    });
  }

  Future<void> loadMessage() async {
    emit(MessagesLoading());
    try {
      for (Conversation convers in conversations) {
        List<Message>? messagesById =
            await (Api().getMessages(convers.conversationId!)) ?? [];
        _currentMapMessages[convers.conversationId!] = messagesById;
      }
      emit(MessagesLoaded(_currentMapMessages));
    } catch (e) {
      print(e.toString());
      emit(MessagesError(e.toString()));
    }
  }

  List<Message>? getMessages(String conversId) {
    return _currentMapMessages[conversId];
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
