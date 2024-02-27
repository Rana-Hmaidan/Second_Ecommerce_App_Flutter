import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';

class FavoriteItemModel {
  final String id;
  final ProductItemModel product;

  FavoriteItemModel({
    required this.id,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'product': product.toMap()});
  
    return result;
  }

  factory FavoriteItemModel.fromMap(Map<String, dynamic> map) {
    return FavoriteItemModel(
      id: map['id'] ?? '',
      product: ProductItemModel.fromMap(map['product'],map['product']['id']),
    );
  }

  FavoriteItemModel copyWith({
    String? id,
    ProductItemModel? product,
  }) {
    return FavoriteItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
    );
  }
}

List<FavoriteItemModel> dummyfavorites = [];