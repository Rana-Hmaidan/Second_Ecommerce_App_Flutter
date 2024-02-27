import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/announcement_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/home_services.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> addProduct(ProductItemModel product) async{
    await homeServices.addProduct(product);
  }

   Future<void> deleteProduct(String id) async {
    await homeServices.deleteProduct(id);
  }

  Future<void> addAnnouncement(AnnouncementModel announcement) async{
    await homeServices.addAnnouncement(announcement);
  }

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.getProducts();
      final announcements = await homeServices.getAnnouncements();
      emit(HomeLoaded(products, announcements));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

    Future<void> addToFavorites(String productId) async {
    emit(AddingToFavorites());
    try {
      final product = await homeServices.getProduct(productId);
      final favoriteItem = FavoriteItemModel(
        id: DateTime.now().toIso8601String(),
        product: product,
      );
      final currentUser = await authServices.currentUser();
      await homeServices.addToFavorites(currentUser!.uid, favoriteItem);
      emit(AddedToFavorites());
    } catch (e) {
      emit(AddToFavoritesError(e.toString()));
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    emit(AddingToFavorites());
    try {
      final product = await homeServices.getProduct(productId);
      final favoriteItem = FavoriteItemModel(
        id: DateTime.now().toIso8601String(),
        product: product,
      );
      final currentUser = await authServices.currentUser();
      await homeServices.removeFromFavorites(currentUser!.uid, favoriteItem);
      emit(AddedToFavorites());
    } catch (e) {
      emit(AddToFavoritesError(e.toString()),);
    }
  }
}