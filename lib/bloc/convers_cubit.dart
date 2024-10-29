import 'package:chatapp/models/convers_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/app_api.dart';

abstract class ConversationState {}
class ConversationInitial extends ConversationState{
}
class ConversationLoading extends ConversationState{}
class ConversationLoaded extends ConversationState{
  final List<Conversation> conversations;
  ConversationLoaded(this.conversations);
}
class ConversationError extends ConversationState{
  String message;
  ConversationError(this.message);
}


class ConversationCubit extends Cubit<ConversationState>{
  // Private constructor
  ConversationCubit._internal() : super(ConversationInitial());

  // Singleton instance
  static final ConversationCubit _instance = ConversationCubit._internal();

  // Factory method to provide the singleton instance
  factory ConversationCubit() {
    return _instance;
  }
  Future<void> loadConvers() async{
    emit(ConversationLoading());
    try{
      var conversations = await Api().getConversations();
      //loadMessage(conversations);
      emit(ConversationLoaded(conversations));
    }catch(e){
      emit(ConversationError(e.toString()));
    }
  }
  void reset() {
    emit(ConversationInitial());
  }
}
