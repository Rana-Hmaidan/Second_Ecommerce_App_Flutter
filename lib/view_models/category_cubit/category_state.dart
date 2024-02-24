part of 'category_cubit.dart';

sealed class CategoryState {
   CategoryState();
}

final class CategoryInitial extends CategoryState{}

final class CategoryLoading extends CategoryState{}

final class CategoryLoaded extends CategoryState {
   final List<CategoryItemModel> categories;

  CategoryLoaded(this.categories);
}

final class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}