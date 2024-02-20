import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getUserDetails(String userId) async {
    emit(EditProfileLoading());
    try {
      final user = dummyUsers.firstWhere((user) => user.id == userId);
      await Future.delayed(const Duration(seconds: 1));
      emit(EditProfileLoaded(user));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> EditProfile(String email, String username) async {
    emit(EditProfileLoading());
  }
}