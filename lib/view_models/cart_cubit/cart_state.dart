part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState{}

final class CartLoading extends CartState{}

final class CartLoaded extends CartState{
  final List<ProductItemModel> cartItems;
  final double subtotal;

  const CartLoaded({
    required this.cartItems,
    required this.subtotal,
  });
}

class QuantityCounterLoaded extends CartState{
  final int value;
  final String productId;
  
  const QuantityCounterLoaded({
    required this.value,
    required this.productId,
  });
}

final class CartError extends CartState{
  final String message;

  const CartError({
    required this.message
  });
}