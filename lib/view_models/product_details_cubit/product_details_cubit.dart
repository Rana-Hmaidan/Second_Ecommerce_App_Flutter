import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/cart_orders_model.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';
//import 'package:second_ecommerce_app_flutter/models/cart_orders_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:second_ecommerce_app_flutter/services/product_details_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final productDetailsServices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();

  ProductSize? size;
  int counter = 1;

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productDetailsServices.getProduct(productId);
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

  void changeSize(ProductSize value) {
    size = value;
    emit(SizeChanged(size!));
  }

  Future<void> addToCart(String productId) async {
    emit(AddingToCart());
    try {
      final product = await productDetailsServices.getProduct(productId);
      final cartOrder = CartOrdersModel(
        id: DateTime.now().toIso8601String(),
        product: product,
        totalPrice: counter * product.price,
        quantity: counter,
        size: size!,
      );
      final currentUser = await authServices.currentUser();
      await productDetailsServices.addToCart(currentUser!.uid, cartOrder);
      emit(AddedToCart());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

  Future<void> addToFavorites(String productId) async {
    emit(AddingToFavorites());
    try {
      final product = await productDetailsServices.getProduct(productId);
      final favoriteItem = FavoriteItemModel(
        id: DateTime.now().toIso8601String(),
        product: product,
      );
      final currentUser = await authServices.currentUser();
      await productDetailsServices.addToFavorites(currentUser!.uid, favoriteItem);
      emit(AddedToFavorites());
    } catch (e) {
      emit(AddToFavoritesError(e.toString()));
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    emit(AddingToFavorites());
    try {
      final product = await productDetailsServices.getProduct(productId);
      final favoriteItem = FavoriteItemModel(
        id: DateTime.now().toIso8601String(),
        product: product,
      );
      final currentUser = await authServices.currentUser();
      await productDetailsServices.removeFromFavorites(currentUser!.uid, favoriteItem);
      emit(AddedToFavorites());
    } catch (e) {
      emit(AddToFavoritesError(e.toString()),);
    }
  }
}




  // void getProductDetails(String productId) async {
  //   emit(ProductDetailsLoading());
  //   try {
  //     final product = dummyProducts.firstWhere((product) => product.id == productId);
  //     await Future.delayed(const Duration(seconds: 2));
  //     emit(ProductDetailsLoaded(product));
  //   } catch (e) {
  //     emit(ProductDetailsError(e.toString()));
  //   }
  // }

  // void incrementCounter() {
  //   counter++;
  //   emit(QuantityChanged(counter));
  // }

  // void decrementCounter() {
  //   if (counter > 1) {
  //     counter--;
  //   }
  //   emit(QuantityChanged(counter));
  // }
  
  // Future<void> decrement(String productId) async{
  //   emit(QuantityCounterLoading());
  //   try{
  //     await Future.delayed(const Duration(seconds: 1));
  //     final index = dummyProducts.indexWhere((item) => item.id == productId);
  //     dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity - 1);
  //     emit(QuantityCounterLoaded(value: dummyProducts[index].quantity, productId: productId));
  //     await Future.delayed(const Duration(seconds: 1));
  //     emit( ProductDetailsLoaded( dummyProducts[index],));
  //   } catch(e){
  //      emit(AddToCartError(e.toString()));
  //   }
  // }
  // Future<void> increment(String productId) async{
  //   emit(QuantityCounterLoading());
  //   try{
  //     await Future.delayed(const Duration(seconds: 1));
  //     final index = dummyProducts.indexWhere((item) => item.id == productId);
  //     dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity + 1);
  //     emit(QuantityCounterLoaded(value: dummyProducts[index].quantity, productId: productId));
  //     await Future.delayed(const Duration(seconds: 1));
  //     emit( ProductDetailsLoaded( dummyProducts[index],));
  //   } catch(e){
  //      emit(AddToCartError(e.toString()));
  //   }
  // }

//   void increment(String productId){
//       emit(ProductDetailsLoading());
//       final index = dummyProducts.indexWhere((item) => item.id == productId);
//       dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity + 1);
//       emit(QuantityCounterLoaded(value: dummyProducts[index].quantity, productId: productId));
//       Future.delayed(const Duration(seconds: 1),(){
//       emit(
//         ProductDetailsLoaded(
//           dummyProducts[index],
//         ));
//     });
//   }
  
//   void decrement(String productId){
//     emit(ProductDetailsLoading());
//      final index = dummyProducts.indexWhere((item) => item.id == productId);
//       dummyProducts[index] = dummyProducts[index].copyWith(quantity: dummyProducts[index].quantity - 1);
//       emit(QuantityCounterLoaded(value: dummyProducts[index].quantity, productId: productId));

//       Future.delayed(const Duration(seconds: 1),(){
//       emit(
//         ProductDetailsLoaded(
//           dummyProducts[index],
//         ));
//     });
//   }
  
//   void changeSize(ProductSize value) {
//     size = value;
//     emit(SizeChanged(size!));
//   }

// Future<void> addToCart(String productId) async{
//     emit(AddingToCart());
//     try{
//       await Future.delayed(const Duration(seconds: 1));
//       final index = dummyProducts.indexWhere((item) => item.id == productId);
//       dummyProducts[index] = dummyProducts[index].copyWith(
//         isAddedToCart: true, 
//         quantity: dummyProducts[index].quantity, 
//         size: size!,
//         price: dummyProducts[index].quantity * dummyProducts[index].price,
//       );
//       emit(AddedToCart());
//       emit(ProductDetailsLoaded(dummyProducts[index],));
//     } catch (e) {
//       emit(AddToCartError(e.toString()));
//     }
//   }

//     Future<void> addToFavorites(String productId) async{
//     emit(ProductDetailsLoading());
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       final index = dummyProducts.indexWhere((product) => product.id == productId);
//       dummyProducts[index] = dummyProducts[index].copyWith(isFavorite: !dummyProducts[index].isFavorite);
//       emit(ProductDetailsLoading());
//       emit(ProductDetailsLoaded( dummyProducts[index],));
//     } catch (e) {
//       emit(ProductDetailsError(e.toString()));
//     }
//   }
  
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
