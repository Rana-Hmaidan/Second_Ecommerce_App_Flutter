import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/announcement_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();

   Future<void> addProduct(ProductItemModel product) async{
    await homeServices.addProduct(product);
  }

   Future<void> deleteProduct(String id) async {
    await homeServices.deleteProduct(id);
  }

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.getProducts();
      //final announcements = dummyAnnouncements;
      final announcements = await homeServices.getAnnouncements();
      emit(HomeLoaded(products, announcements));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}