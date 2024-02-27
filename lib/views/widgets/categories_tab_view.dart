import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/view_models/category_cubit/category_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/category_item.dart';

class CategoriesTabView extends StatelessWidget {
  const CategoriesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryCubit>(context);

    for(final category in dummyCategories){
      cubit.addCategory(category);
    }
    
    return BlocBuilder<CategoryCubit, CategoryState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is CategoryLoading ||
          current is CategoryLoaded ||
          current is CategoryError,
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is CategoryError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is CategoryLoaded) {
          final categories = state.categories;
          return ListView.separated(
            itemCount: categories.length,
            padding: const EdgeInsets.all(16.0),
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
              CategoryItem(categoryItem: categories[index]),
            );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
