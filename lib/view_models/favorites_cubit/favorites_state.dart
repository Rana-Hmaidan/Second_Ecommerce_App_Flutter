part of 'favorites_cubit.dart';

class FavoritesState {}

class FavoriteLoadingState extends FavoritesState{}

class FavoriteLoadedState extends FavoritesState{
  final List<FavoriteItemModel> favorites;

  FavoriteLoadedState(this.favorites);
}

class FavoriteError extends FavoritesState{
  final String message;

   FavoriteError({
    required this.message
  });
}

final class CategoryLoading extends FavoritesState{}

final class CategoryLoaded extends FavoritesState {
   final List<CategoryItemModel> categories;

  CategoryLoaded(this.categories);
}

final class CategoryError extends FavoritesState {
  final String message;
  CategoryError(this.message);
}