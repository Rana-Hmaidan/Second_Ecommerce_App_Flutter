import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';
//import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:second_ecommerce_app_flutter/services/favorites_services.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState>{

  FavoritesCubit() : super(FavoritesState());

  final favoritesServices = FavoritesServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getFavoritesItems() async {
    emit(FavoriteLoadingState());
    try {
      final currentUser = await authServices.currentUser();
      final favoritesItems = await favoritesServices.getFavoritesItems(currentUser!.uid);
      emit(FavoriteLoadedState(
        favoritesItems,
      ));
    } catch (e) {
      emit(
        FavoriteError(message: e.toString()),
      );
    }
  }

  Future<void> getFilteredFavorites(String category) async {
    emit(FavoriteLoadingState());
    try{
      final currentUser = await authServices.currentUser();
      final favoritesItems = await favoritesServices.getFavoritesItems(currentUser!.uid);
      final filteredFavoritesItems = favoritesItems.where((item) => item.product.category == category,).toList();
      emit(FavoriteLoadedState(
        filteredFavoritesItems,
      ));
    }catch(e){
      emit(
        FavoriteError(message: e.toString()),
      );
    }
  }

   Future<void> removeFromFavorites(FavoriteItemModel favoriteItem) async {
    emit(FavoriteLoadingState());
    try {
      final currentUser = await authServices.currentUser();
      await favoritesServices.deleteFavoriteItem(
        currentUser!.uid,
        favoriteItem,
      );
      final favoritesItems = await favoritesServices.getFavoritesItems(currentUser.uid);
      emit(FavoriteLoadedState(
        favoritesItems,
      ));
    } catch (e) {
      emit(
        FavoriteError(message: e.toString()),
      );
    }
  }

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await favoritesServices.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

 

  //  Future<void> loadFilteredFavorites(String category) async{
  //   emit(FavoriteLoadingState());
  //   try{
  //     final filteredfavorites = await favoritesServices.getFilteredFavoritesItems(uid);
  //   }catch(e){

  //   }
  //  // final filteredfavoriteList = dummyProducts.where((item) => (favoriteProducts[item.id]  ?? false ) && item.category == category).toList();
  // } 

  // Future<void> loadCategories() async{
  //   await Future.delayed(const Duration(seconds: 1));
  //   final categories = dummyCategories;
  //   emit(CategoryLoadedState(categories: categories));
  // } 





}

  // Map<String , bool>  favoriteProducts = {};
  // Map<String , bool> loadingProducts = {};
  // bool isLoading = false;

  // FavoritesCubit() : super(FavoritesState());

  // Future<void> addFavorite(String productId) async{
  //   loadingProducts[productId] = true;
  //   emit(FavoriteLoadingState());
  //   await Future.delayed(const Duration(seconds: 1));
  //   loadingProducts.remove(productId);
  //   favoriteProducts[productId] = true;
  //   final favoriteList = dummyProducts.where((item) => favoriteProducts[item.id] ?? false).toList();
  //   emit(FavoriteLoadedState(favoriteList));
  // }

  // Future<void> deleteFavorite(String productId) async{
  //   loadingProducts[productId] = true;
  //   emit(FavoriteLoadingState());
  //   await Future.delayed(const Duration(seconds: 1));
  //   loadingProducts.remove(productId);
  //   favoriteProducts[productId] = false;
  //   final favoriteList = dummyProducts.where((item) => favoriteProducts[item.id] ?? false).toList();
  //   emit(FavoriteLoadedState(favoriteList));
  // }

  // Future<void> loadFavoriteProducts() async{
  //   emit(FavoriteLoadingState());
  //   await Future.delayed(const Duration(seconds: 1));
  //   final favoriteList = dummyProducts.where((item) => (favoriteProducts[item.id] ?? false)).toList();
  //   emit(FavoriteLoadedState(favoriteList));
  // } 

  // Future<void> loadFilteredFavorites(String category) async{
  //   emit(FavoriteLoadingState());
  //   await Future.delayed(const Duration(seconds: 1));
  //   final filteredfavoriteList = dummyProducts.where((item) => (favoriteProducts[item.id]  ?? false ) && item.category == category).toList();
  //   emit(FavoriteLoadedState(filteredfavoriteList));
  // } 

  // Future<void> loadCategories() async{
  //   await Future.delayed(const Duration(seconds: 1));
  //   final categories = dummyCategories;
  //   emit(CategoryLoadedState(categories: categories));
  // } 

