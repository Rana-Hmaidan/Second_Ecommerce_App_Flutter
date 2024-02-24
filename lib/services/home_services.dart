import 'package:second_ecommerce_app_flutter/models/announcement_model.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> getProducts();
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<List<CategoryItemModel>> getCategories();
  Future<void> addProduct(ProductItemModel product);
  Future<void> deleteProduct(String id);
}

class HomeServicesImpl extends HomeServices {
  final firestoreService = FirestoreService.instance;

    @override
  Future<void> addProduct(ProductItemModel product) async => 
    await firestoreService.setData(path: ApiPaths.product(product.id), data: product.toMap());
  
  @override
  Future<void> deleteProduct(String id) async => 
    await firestoreService.deleteData(path: ApiPaths.product(id));

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
  
}