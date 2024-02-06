import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/category_item.dart';

class CategoriesTabView extends StatelessWidget {
  const CategoriesTabView({super.key});

  @override
  Widget build(BuildContext context) {
      return ListView.separated(
          itemCount: dummyCategories.length,
          padding: const EdgeInsets.all(16.0),
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => CategoryItem(categoryItem: dummyCategories[index]),
      );
  }
}