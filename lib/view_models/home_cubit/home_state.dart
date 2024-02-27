part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemModel> products;
  final List<AnnouncementModel> announcements;
  HomeLoaded(this.products, this.announcements);
}

final class AddingToFavorites extends HomeState {}

final class AddedToFavorites extends HomeState {}

final class AddToFavoritesError extends HomeState {
  final String message;

  AddToFavoritesError(this.message);
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}