class CategoryItemModel{
  final String id;
  final String name;
  final String imgUrl;
  final int productsCount;

  CategoryItemModel({
    required this.id,
    required this.name, 
    required this.imgUrl, 
    required this.productsCount,
  });

   Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'productsCount': productsCount});

    return result;
  }

  factory CategoryItemModel.fromMap(
    Map<String, dynamic> map, String documentId) {

    return CategoryItemModel(
      id: documentId,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      productsCount: map['productsCount'].toInt() ?? 0 ,
    );
  }
}

List<CategoryItemModel> dummyCategories =[
  CategoryItemModel(
    id: 'baurFqSyvIJJN7x1IY5a', 
    name: 'New Arrivals', 
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCzvqy4roLm4pxSDTG8pyHZUqmMfo0EBokXA&usqp=CAU',
    productsCount: 208
  ),
   CategoryItemModel(
    id: '8sYCXCOK3zaXAWSqF6AK', 
    name: 'Clothes', 
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBq1z9gD3GKt7N4QRZ23HrLln0g00zLjZ6wN5dXQ5LjSqraRiuCoOqkynwAj3y7AAOK8o&usqp=CAU',
    productsCount: 358
  ),
   CategoryItemModel(
    id: 'qCau6o54VXN7r7SwWSPL', 
    name: 'Bags', 
    imgUrl: 'https://t3.ftcdn.net/jpg/02/48/72/46/360_F_248724638_CmVOwxQz3VBwlp24cgYEIcLuD4CVZ9tb.jpg',
    productsCount: 160
  ),
   CategoryItemModel(
    id: 'aEEUokixpK8jevluv8t7', 
    name: 'Shoes', 
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEouTYWo5AEIrFo0U7ino0SySFxpnSuHRrV9Eh978G1GgJBU4CJRNXxx-IR8WimLPAOaw&usqp=CAU',
    productsCount: 230
  ),
  CategoryItemModel(
    id: 'wEGe0m8FeEeCLbNAy57U', 
    name: 'Hats',
    imgUrl: 'https://cms.cloudinary.vpsvc.com/images/c_scale,dpr_auto,f_auto,q_auto:best,t_productPageHeroGalleryTransformation,w_auto/legacy_dam/en-ie/s001208848/Standard-Embroidred-Hat-hero-001', 
    productsCount: 120
  ),
  
  CategoryItemModel(
    id: 'mop8PilkbCH41nVKXh9i', 
    name: 'Electronics',
    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Mz9GR52aOkxbJE4ZMiENzTFuVz59XEZ8McMYAMHXfQZtGyZQBUzf7nIStr2qS5ifOw&usqp=CAU', 
    productsCount: 170
  ),
  
];
