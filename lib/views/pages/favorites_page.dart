import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/category_chip_widget.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/product_item.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/search_bar_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  String? selectedCategory;
  late List<ProductItemModel> filteredfavoritesProducts;

  @override
  void initState() {
    super.initState();
    filteredfavoritesProducts = favProducts;
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 16.0),
              ListView.separated(
                    itemCount: dummyCategories.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final dummyCategory = dummyCategories[index];
                      return CategoryChipWidget(
                        label: dummyCategory.name, 
                        isSelected: selectedCategory == dummyCategory.name ? true : false,
                        onTap:() {
                         setState(() {
                            // if the category is already selected, unselect it
                            if (selectedCategory != null &&
                                selectedCategory == dummyCategory.name) {
                                selectedCategory = null;
                                filteredfavoritesProducts = favProducts;
                              // if the category is not selected, select it
                            } else {
                              selectedCategory = dummyCategory.name;
                              filteredfavoritesProducts = favProducts
                                  .where((product) =>
                                      product.category == selectedCategory)
                                  .toList();
                            }
                          });
                        }
                      );
                },
              ),
              const SizedBox(height: 16.0),
              if (filteredfavoritesProducts.isNotEmpty)
              Expanded(
                child: GridView.builder(
                        itemCount: filteredfavoritesProducts.length,
                        //shrinkWrap: true,
                        //physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5 /2,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: (){

                          },
                          child: ProductItem(productItem: filteredfavoritesProducts[index]),
                          ),
                  ), 
              ), 
              if (filteredfavoritesProducts.isEmpty)
              const Center(
                child: Text('No products found'),
              ),
            ],
          ),
        ),
      );
  }
}