import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/cart_orders_model.dart';
//import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:second_ecommerce_app_flutter/services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit() : super(CartInitial());

  final cartServices = CartServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final currentUser = await authServices.currentUser();
      final cartItems = await cartServices.getCartItems(currentUser!.uid);
      final subTotal = cartItems.fold<double>(
          0, (sum, item) => sum + (item.product.price * item.quantity));
      emit(CartLoaded(
        cartItems: cartItems,
        subtotal: subTotal,
      ));
    } catch (e) {
      emit(
        CartError(message: e.toString()),
      );
    }
  }

   Future<void> incrementCounter(CartOrdersModel cartOrder) async {
    emit(QuantityCounterLoading(cartOrderId: cartOrder.id));
    try {
      cartOrder = cartOrder.copyWith(quantity: cartOrder.quantity + 1);
      final currentUser = await authServices.currentUser();
      await cartServices.updateCartItem(
        currentUser!.uid,
        cartOrder,
      );
      emit(
        QuantityCounterLoaded(
          value: cartOrder.quantity,
          cartOrder: cartOrder,
        ),
      );
    } catch (e) {
      emit(QuantityCounterError(message: e.toString()));
    }
  }

  Future<void> decrementCounter(CartOrdersModel cartOrder) async {
    emit(QuantityCounterLoading(cartOrderId: cartOrder.id));
    try {
      cartOrder = cartOrder.copyWith(quantity: cartOrder.quantity - 1);
      final currentUser = await authServices.currentUser();
      await cartServices.updateCartItem(
        currentUser!.uid,
        cartOrder,
      );
      emit(
        QuantityCounterLoaded(
          value: cartOrder.quantity,
          cartOrder: cartOrder,
        ),
      );
    } catch (e) {
      emit(QuantityCounterError(message: e.toString()));
    }
  }

  Future<void> removeFromCart(CartOrdersModel cartOrder) async {
    emit(CartLoading());
    try {
      final currentUser = await authServices.currentUser();
      await cartServices.deleteCartItem(
        currentUser!.uid,
        cartOrder,
      );
      final cartItems = await cartServices.getCartItems(currentUser.uid);
      final subTotal = cartItems.fold<double>( 0, (sum, item) => sum + (item.product.price * item.quantity));
      emit(CartLoaded(
        cartItems: cartItems,
        subtotal: subTotal,
      ));
    } catch (e) {
      emit( CartError(message: e.toString()),);
    }
  }

}

  // void getCartItems(){
  //   emit(CartLoading());
  //   final cartItems = dummyProducts.where((item) => item.isAddedToCart == true).toList();
  //   //final cartItems = dummyCartOrders;
  //   final subTotal = cartItems.fold<double>(0, (sum, item) => sum + item.price);
  //   Future.delayed(const Duration(seconds: 1),(){
  //     emit(
  //       CartLoaded(
  //         cartItems: cartItems,
  //         subtotal: subTotal,
  //       ),
  //     );
  //   });
  // }

  // void increment(String productId){
  //     final index = dummyProducts.indexWhere((item) => item.id == productId);
  //     dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity + 1);
  //     emit( QuantityCounterLoaded( value: dummyProducts[index].quantity, productId: productId));
  // }

  // void decrement(String productId){
  //    final index = dummyProducts.indexWhere((item) => item.id == productId);
  //     dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity - 1);
  //     emit( QuantityCounterLoaded( value: dummyProducts[index].quantity, productId: productId));
  // }

  // void removeFromCart(String productId){
  //   emit(CartLoading());
  //   final index = dummyProducts.indexWhere((item) => item.id == productId);
  //   dummyProducts[index] = dummyProducts[index].copyWith(isAddedToCart: false, quantity: 0, size: null);
  //   final cartItems = dummyProducts.where((item) => item.isAddedToCart == true).toList();
  //   final subTotal = cartItems.fold<double>(0, (sum, item) => sum + item.price);
  //   Future.delayed(const Duration(seconds: 1),(){
  //     emit(
  //       CartLoaded(
  //        cartItems: cartItems,
  //        subtotal: subTotal,
  //       ));
  //   });
  // }
