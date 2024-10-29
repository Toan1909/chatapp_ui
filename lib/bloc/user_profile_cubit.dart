import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../network/app_api.dart';

abstract class UserProfileState {}
class ProfileInitial extends UserProfileState{
}
class ProfileLoading extends UserProfileState{}
class ProfileLoaded extends UserProfileState{
  final User user;
  ProfileLoaded(this.user);
}
class ProfileError extends UserProfileState{
  String message;
  ProfileError(this.message);
}


class ProfileCubit extends Cubit<UserProfileState>{
  ProfileCubit() : super(ProfileInitial());
  Future<void> loadProfile() async{
    emit(ProfileLoading());
    try{
      var user = await Api().getProfile();
      //loadMessage(conversations);
      emit(ProfileLoaded(user));

    }catch(e){
      emit(ProfileError(e.toString()));
    }
  }

}
