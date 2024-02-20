part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class EditProfileLoading extends ProfileState {}

final class EditProfileLoaded extends ProfileState {
  User user;
  EditProfileLoaded(this.user);
}

final class EditProfileError extends ProfileState {
  final String message;
  EditProfileError(this.message);
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}