part of 'favorites_cubit.dart';

class FavoritesState {}

class FavoriteLoadingState extends FavoritesState{}

class FavoriteLoadedState extends FavoritesState{
  final List<ProductItemModel> products;

  FavoriteLoadedState(this.products);
}

class CategoryLoadedState extends FavoritesState{
  final List<CategoryItemModel> categories;

   CategoryLoadedState({
    required this.categories,
  });
}

class FavoriteError extends FavoritesState{
  final String message;

   FavoriteError({
    required this.message
  });
}