import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/services/home_services.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit() : super(CategoryInitial());

  final homeServices = HomeServicesImpl();

  // Future<void> addCategory(CategoryItemModel category) async{
  //   await homeServices.addCategory(category);
  // }

  Future<void> getCategoryData() async {
    emit(CategoryLoading());
    try {
      final categories = await homeServices.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // void getCategoryData(){
  //   emit(CategoryLoading());
  //   Future.delayed(const Duration(seconds: 2),(){
  //     emit(
  //       CategoryLoaded(
  //         categories: dummyCategories, 
  //       ));
  //   });
  // }
}
