import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/user_data.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final AuthServices authServices = AuthServicesImpl();

  // Future<void> getUserProfile() async {
  //   emit(ProfileLoading());
  //   try {
  //     final currentUser = await authServices.currentUser();
  //     final user = await authServices.getUser(currentUser!.uid);
  //     await Future.delayed(const Duration(seconds: 1));
  //     emit(ProfileLoaded(user!));
  //   } catch (e) {
  //     emit(ProfileError(e.toString()));
  //   }
  // }

  Future<void> getUserDetails() async {
    emit(EditProfileLoading());
    try {
      final currentUser = await authServices.currentUser();
      final user = await authServices.getUser(currentUser!.uid);
      await Future.delayed(const Duration(seconds: 1));
      emit(EditProfileLoaded(user!));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> editProfile(String uId, String email, String username) async {
    emit(SaveChangesLoading());
    try{
      UserData? user = await authServices.getUser(uId);
      user =  user!.copyWith(email: email, username: username);
      await authServices.updateUserData(
        user.id, 
        user
      );
      if(user.id == uId){
        emit(SaveChangesSuccess());
      }
      else{
        emit(SaveChangesFailure('Failed to Update!'));
      }
      emit(EditProfileLoaded(user));
    }catch (e){
      EditProfileError(e.toString());
    } 
  }
}