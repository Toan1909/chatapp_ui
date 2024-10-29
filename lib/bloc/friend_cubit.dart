import 'package:chatapp/models/convers_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import '../network/app_api.dart';
import '../shared/spref.dart';

abstract class FriendsState {}
class FriendsInitial extends FriendsState{
}
class FriendsLoading extends FriendsState{}
class FriendsLoaded extends FriendsState{

  List<User> friends =[];
  List<User> pendings =[];
  FriendsLoaded(this.friends, this.pendings);
}
class FriendsError extends FriendsState{
  String message;
  FriendsError(this.message);
}


class FriendsCubit extends Cubit<FriendsState>{
  // Private constructor
  FriendsCubit._internal() : super(FriendsInitial());

  // Singleton instance
  static final FriendsCubit _instance = FriendsCubit._internal();

  // Factory method to provide the singleton instance
  factory FriendsCubit() {
    return _instance;
  }
  Future<void> loadFriends() async{
    emit(FriendsLoading());
    try{
      var uId = await SPref.instance.get('userId');
      var friends = await Api().getFriends(uId);
      var pendings = await Api().getPendings(uId);
      emit(FriendsLoaded(friends,pendings));
    }catch(e){
      emit(FriendsError(e.toString()));
    }
  }
  void reset() {
    emit(FriendsInitial());
  }

}
