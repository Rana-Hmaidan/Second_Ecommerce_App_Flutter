import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/announcement_model.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = dummyProducts;
      final announcements = dummyAnnouncements;
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeLoaded(products, announcements));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}