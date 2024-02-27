import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/category_chip_widget.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/favorite_item_widget.dart';
//import 'package:second_ecommerce_app_flutter/views/widgets/product_item.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/search_bar_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  String? selectedCategory;

 @override
 void initState(){
    BlocProvider.of<FavoritesCubit>(context).getFavoritesItems();
    BlocProvider.of<FavoritesCubit>(context).getCategories();
    selectedCategory = null;
    super.initState();
 }

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<FavoritesCubit>(context);

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  bloc: cubit,
                  buildWhen:(previous, current) => 
                    current is CategoryLoading ||
                    current is CategoryLoaded ||
                    current is CategoryError,
                  builder: (context, state) {
                   if(state is CategoryLoading){
                    return const Center(
                      child: CircularProgressIndicator.adaptive()
                    );
                    } else if(state is CategoryLoaded){
                      final categories = state.categories;
                      return Wrap(
                        direction: Axis.horizontal,
                        children: categories.map((category) {
                          return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Expanded(
                                child: CategoryChipWidget(
                                  label: category.name, 
                                  isSelected: selectedCategory == category.name ? true : false,
                                  onTap: (){
                                    // if the category is already selected, unselect it
                                    if (selectedCategory != null && selectedCategory == category.name) {
                                      selectedCategory = null;
                                      cubit.getFavoritesItems();
                                    // if the category is not selected, select it
                                    }else {
                                      selectedCategory = category.name;
                                      cubit.getFilteredFavorites(selectedCategory!);
                                  } 
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    );
                  }else{
                    return const SizedBox();
                  }
                }
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  bloc: cubit,
                  buildWhen: (previous, current) => 
                    current is FavoriteLoadedState ||
                    current is FavoriteLoadingState ||
                    current is FavoriteError,
                  builder: (context, state) {
                    if(state is FavoriteLoadingState){
                      return const Center(
                        child:  CircularProgressIndicator.adaptive()
                      );
                    }else if(state is FavoriteLoadedState){
                      final favorites = state.favorites;
                      return RefreshIndicator(
                        onRefresh: () => cubit.getFavoritesItems(),
                        child: GridView.builder(
                          itemCount: favorites.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 2,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              Navigator.of(context, rootNavigator: true).pushNamed(
                                AppRoutes.productDetails,
                                arguments: favorites[index],
                              );
                            },
                            child: FavoriteItem(favoriteItem: favorites[index]),
                            ),
                        ),
                      );
                    }else{
                      return const SizedBox();
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      );
  }
}
