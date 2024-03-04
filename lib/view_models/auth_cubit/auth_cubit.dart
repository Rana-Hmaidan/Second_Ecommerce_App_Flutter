import 'package:second_ecommerce_app_flutter/models/user_data.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.signInWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Failed to sign in'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword(String userName ,String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await authServices.signUpWithEmailAndPassword(userName, email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Failed to sign up'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }


  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authServices.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await authServices.currentUser();
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

   Future<UserData?> getCurrentUserData() async {
    emit(AuthLoading());
    try {
      final currentUser = await authServices.currentUser();
      final user = await authServices.getUser(currentUser!.uid);
      if (user!= null) {
        emit(AuthLoaded(user));
        return user;
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
    return null;
  }
}