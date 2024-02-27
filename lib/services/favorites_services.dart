import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';

abstract class FavoritesServices {
  Future<List<FavoriteItemModel>> getFavoritesItems(String uid);
  Future<void> deleteFavoriteItem(String uid, FavoriteItemModel favoriteItem);
  Future<List<CategoryItemModel>> getCategories();
}

class FavoritesServicesImpl implements FavoritesServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<FavoriteItemModel>> getFavoritesItems(String uid) async =>
    await firestoreService.getCollection<FavoriteItemModel>(
      path: ApiPaths.favoriteItems(uid),
      builder: (data, documentId) => FavoriteItemModel.fromMap(data),
    );
      
  @override
  Future<void> deleteFavoriteItem(String uid, FavoriteItemModel favoriteItem) async =>
    await firestoreService.deleteData(path: ApiPaths.favoriteItem(uid, favoriteItem.id));
    
  @override
  Future<List<CategoryItemModel>> getCategories() async =>
    await firestoreService.getCollection<CategoryItemModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryItemModel.fromMap(data, documentId),
  );
  
}