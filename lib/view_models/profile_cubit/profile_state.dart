part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  UserData user;
  ProfileLoaded(this.user);
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}


final class EditProfileLoading extends ProfileState {}

final class EditProfileLoaded extends ProfileState {
  UserData user;
  EditProfileLoaded(this.user);
}

final class EditProfileError extends ProfileState {
  final String message;
  EditProfileError(this.message);
}

final class SaveChangesLoading extends ProfileState {}
final class SaveChangesSuccess extends ProfileState {}

final class SaveChangesFailure extends ProfileState {
  final String message;

  SaveChangesFailure(this.message);
}
