import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:second_ecommerce_app_flutter/models/cart_orders_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSize? size;
  int counter = 0;
  //bool isFavorites = false;

  void getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = dummyProducts.firstWhere((product) => product.id == productId);
      await Future.delayed(const Duration(seconds: 2));
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  void incrementCounter() {
    counter++;
    emit(QuantityChanged(counter));
  }

  void decrementCounter() {
    if (counter > 1) {
      counter--;
    }
    emit(QuantityChanged(counter));
  }
  
  Future<void> decrement(String productId) async{
    emit(QuantityCounterLoading());
    try{
      await Future.delayed(const Duration(seconds: 1));
      final index = dummyProducts.indexWhere((item) => item.id == productId);
      dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity - 1);
      emit(QuantityCounterLoaded(value: dummyProducts[index].quantity, productId: productId));
      await Future.delayed(const Duration(seconds: 1));
      emit( ProductDetailsLoaded( dummyProducts[index],));
    } catch(e){
       emit(AddToCartError(e.toString()));
    }
  }
  Future<void> increment(String productId) async{
    emit(QuantityCounterLoading());
    try{
      await Future.delayed(const Duration(seconds: 1));
      final index = dummyProducts.indexWhere((item) => item.id == productId);
      dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity + 1);
      emit(QuantityCounterLoaded(value: dummyProducts[index].quantity, productId: productId));
      await Future.delayed(const Duration(seconds: 1));
      emit( ProductDetailsLoaded( dummyProducts[index],));
    } catch(e){
       emit(AddToCartError(e.toString()));
    }
  }

  void changeSize(ProductSize value) {
    size = value;
    emit(SizeChanged(size!));
  }

Future<void> addToCart(String productId) async{
    emit(AddingToCart());
    try{
      await Future.delayed(const Duration(seconds: 1));
      final index = dummyProducts.indexWhere((item) => item.id == productId);
      dummyProducts[index] = dummyProducts[index].copyWith(
        isAddedToCart: true, 
        quantity: dummyProducts[index].quantity, 
        size: size!,
        price: dummyProducts[index].quantity * dummyProducts[index].price,
      );
      emit(AddedToCart());
      emit(ProductDetailsLoaded(dummyProducts[index],));
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

    Future<void> addToFavorites(String productId) async{
    emit(ProductDetailsLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final index = dummyProducts.indexWhere((product) => product.id == productId);
      dummyProducts[index] = dummyProducts[index].copyWith(isFavorite: !dummyProducts[index].isFavorite);
      emit(ProductDetailsLoading());
      emit(ProductDetailsLoaded( dummyProducts[index],));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
  
  // Future<void> addToCart(String productId) async {
  //   emit(AddingToCart());
  //   try {
  //     await Future.delayed(const Duration(seconds: 1));
  //     final product = dummyProducts.firstWhere((product) => product.id == productId);
  //     final cartOrder = CartOrdersModel(
  //       id: DateTime.now().toIso8601String(),
  //       product: product,
  //       totalPrice: counter * product.price,
  //       quantity: counter,
  //       size: size!,
  //     );
  //     dummyCartOrders.add(cartOrder);
  //     emit(AddedToCart());
  //   } catch (e) {
  //     emit(AddToCartError(e.toString()));
  //   }
  // }

}