part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthLoaded extends AuthState{
  UserData user;
  AuthLoaded(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}