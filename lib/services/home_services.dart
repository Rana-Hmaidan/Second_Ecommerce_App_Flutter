import 'package:second_ecommerce_app_flutter/models/announcement_model.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';

abstract class HomeServices {
  Future<ProductItemModel> getProduct(String id);
  Future<List<ProductItemModel>> getProducts();
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<List<CategoryItemModel>> getCategories();
  Future<void> addProduct(ProductItemModel product);
  Future<void> deleteProduct(String id);
  Future<void>addCategory(CategoryItemModel category);
  Future<void> addAnnouncement(AnnouncementModel announcement);
  Future<void> addToFavorites(String uid, FavoriteItemModel favoriteItem);
  Future<void> removeFromFavorites(String uid, FavoriteItemModel favoriteItem);
}

class HomeServicesImpl extends HomeServices {

  final firestoreService = FirestoreService.instance;

   @override
  Future<ProductItemModel> getProduct(String id) async =>
      await firestoreService.getDocument<ProductItemModel>(
        path: ApiPaths.product(id),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );

  @override
  Future<void> addProduct(ProductItemModel product) async => 
    await firestoreService.setData(path: ApiPaths.product(product.id), data: product.toMap());
  
  @override
  Future<void> deleteProduct(String id) async => 
    await firestoreService.deleteData(path: ApiPaths.product(id));

  @override
  Future<void> addCategory(CategoryItemModel category) async => 
    await firestoreService.setData(path: ApiPaths.category(category.id), data: category.toMap());

   @override
  Future<void> addAnnouncement(AnnouncementModel announcement) async => 
    await firestoreService.setData(path: ApiPaths.announcement(announcement.id), data: announcement.toMap());
  

  @override
  Future<List<ProductItemModel>> getProducts() async =>
      await firestoreService.getCollection<ProductItemModel>(
        path: ApiPaths.products(),
        builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
  );
  
  @override
  Future<List<AnnouncementModel>> getAnnouncements() async =>
      await firestoreService.getCollection<AnnouncementModel>(
        path: ApiPaths.announcements(),
        builder: (data, documentId) => AnnouncementModel.fromMap(data, documentId),
  );

  @override
  Future<List<CategoryItemModel>> getCategories() async =>
      await firestoreService.getCollection<CategoryItemModel>(
        path: ApiPaths.categories(),
        builder: (data, documentId) => CategoryItemModel.fromMap(data, documentId),
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