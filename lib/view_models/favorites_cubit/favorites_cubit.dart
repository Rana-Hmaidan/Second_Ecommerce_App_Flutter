import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState>{

  Map<String , bool>  favoriteProducts = {};
  Map<String , bool> loadingProducts = {};
  bool isLoading = false;

  FavoritesCubit() : super(FavoritesState());

  Future<void> addFavorite(String productId) async{
    loadingProducts[productId] = true;
    emit(FavoriteLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    loadingProducts.remove(productId);
    favoriteProducts[productId] = true;
    final favoriteList = dummyProducts.where((item) => favoriteProducts[item.id] ?? false).toList();
    emit(FavoriteLoadedState(favoriteList));
  }

  Future<void> deleteFavorite(String productId) async{
    loadingProducts[productId] = true;
    emit(FavoriteLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    loadingProducts.remove(productId);
    favoriteProducts[productId] = false;
    final favoriteList = dummyProducts.where((item) => favoriteProducts[item.id] ?? false).toList();
    emit(FavoriteLoadedState(favoriteList));
  }

  Future<void> loadFavoriteProducts() async{
    emit(FavoriteLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    final favoriteList = dummyProducts.where((item) => (favoriteProducts[item.id] ?? false)).toList();
    emit(FavoriteLoadedState(favoriteList));
  } 

  Future<void> loadFilteredFavorites(String category) async{
    emit(FavoriteLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    final filteredfavoriteList = dummyProducts.where((item) => (favoriteProducts[item.id]  ?? false ) && item.category == category).toList();
    emit(FavoriteLoadedState(filteredfavoriteList));
  } 

  // Future<void> loadCategories() async{
  //   await Future.delayed(const Duration(seconds: 1));
  //   final categories = dummyCategories;
  //   emit(CategoryLoadedState(categories: categories));
  // } 

}