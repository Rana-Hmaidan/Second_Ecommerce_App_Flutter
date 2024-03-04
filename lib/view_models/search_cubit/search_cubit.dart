import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/search_item_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(SearchInitial());

  void getSearchData(){
    emit(SearchLoading());
    Future.delayed(const Duration(seconds: 1),(){
      emit(
        SearchLoaded(
          lastSerchItems: dummylastSearches,
          popularsearchItems: dummyPopularSearches,
        ));
    });
  }
}