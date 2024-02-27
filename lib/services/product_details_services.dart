import 'package:second_ecommerce_app_flutter/models/cart_orders_model.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> getProduct(String id);
  Future<void> addToCart(String uid, CartOrdersModel cartOrder);
  Future<void> addToFavorites(String uid, FavoriteItemModel favoriteItem);
  Future<void> removeFromFavorites(String uid, FavoriteItemModel favoriteItem);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<ProductItemModel> getProduct(String id) async =>
      await firestoreService.getDocument<ProductItemModel>(
        path: ApiPaths.product(id),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );

  @override
  Future<void> addToCart(String uid, CartOrdersModel cartOrder) async =>
      await firestoreService.setData(
        path: ApiPaths.cartItem(uid, cartOrder.id),
        data: cartOrder.toMap(),
      );
  
  @override
  Future<void> addToFavorites(String uid, FavoriteItemModel favoriteItem) async => 
      await firestoreService.setData(
        path: ApiPaths.favoriteItem(uid, favoriteItem.id), 
        data: favoriteItem.toMap(),
      );

  @override
  Future<void> removeFromFavorites(String uid, FavoriteItemModel favoriteItem) async =>
    await firestoreService.deleteData(path: ApiPaths.favoriteItem(uid, favoriteItem.id));
  
}