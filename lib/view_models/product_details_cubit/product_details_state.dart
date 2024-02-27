part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;

  ProductDetailsLoaded(this.product);
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);
}

final class AddingToCart extends ProductDetailsState {}

final class AddedToCart extends ProductDetailsState {}

final class AddToCartError extends ProductDetailsState {
  final String message;

  AddToCartError(this.message);
}

final class AddingToFavorites extends ProductDetailsState {}

final class AddedToFavorites extends ProductDetailsState {}

final class AddToFavoritesError extends ProductDetailsState {
  final String message;

  AddToFavoritesError(this.message);
}

final class QuantityChanged extends ProductDetailsState {
  final int quantity;

  QuantityChanged(this.quantity);
}

final class SizeChanged extends ProductDetailsState {
  final ProductSize size;

  SizeChanged(this.size);
}

// final class QuantityCounterLoading extends ProductDetailsState{}

// final class QuantityCounterLoaded extends ProductDetailsState{
//   final int value;
//   final String productId;
  
//   QuantityCounterLoaded({
//     required this.value,
//     required this.productId,
//   });
// }

// final class QuantityCounterError extends ProductDetailsState {
//   final String message;

//   QuantityCounterError(this.message);
// }