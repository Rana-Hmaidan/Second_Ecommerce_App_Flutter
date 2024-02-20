import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/user_model.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/profile_cubit/profile_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/pages/custom_bottom_navbar.dart';
import 'package:second_ecommerce_app_flutter/views/pages/edit-profile-page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/product_details_page.dart';
import 'package:second_ecommerce_app_flutter/view_models/favorites_cubit/favorites_cubit.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productDetails:
        final product = settings.arguments as ProductItemModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(product.id);
              return cubit;
            },
            child: const ProductDetailsPage(),
          ),
          settings: settings,
        );
      case AppRoutes.editProfile:
      final user = settings.arguments as User;
        return MaterialPageRoute(
         builder: (_) => BlocProvider(
            create: (context){
              final cubit = ProfileCubit();
              cubit.getUserDetails(user.id);
              return cubit;
            },
            child: const EditProfilePage()
          ),
          settings: settings,
        );
      case AppRoutes.bottomNavbar:
        return MaterialPageRoute(
         builder: (_) => BlocProvider(
            create: (context) => FavoritesCubit(),
            child: const CustomBottomNavbar()
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error Page!'),
            ),
          ),
        );
    }
  }
}