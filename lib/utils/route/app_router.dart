import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/models/user_data.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/auth_cubit/auth_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/location_cubit/location_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/payment_cubit/payment_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/profile_cubit/profile_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/search_cubit/search_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/pages/add_payment_card.dart';
import 'package:second_ecommerce_app_flutter/views/pages/create_account_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/custom_bottom_navbar.dart';
import 'package:second_ecommerce_app_flutter/views/pages/edit_profile_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/email_verification_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/location_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/login_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/payment_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/product_details_page.dart';
//import 'package:second_ecommerce_app_flutter/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/pages/search_page.dart';
import 'package:second_ecommerce_app_flutter/view_models/onboarding_cubit/onboarding_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/pages/onboarding_page.dart';

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
      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) {
                final searchCubit = SearchCubit();
                searchCubit.getSearchData();
                return searchCubit;
              },
              child: const SearchPage()),
          settings: settings,
        );
      case AppRoutes.editProfile:
        //final user = settings.arguments as UserData;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) {
                final cubit = ProfileCubit();
                cubit.getUserDetails();
                return cubit;
              },
              child: const EditProfilePage()),
          settings: settings,
        );
      case AppRoutes.locationPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = LocationCubit();
              cubit.getLocations();
              return cubit;
            },
            child: const LocationPage(),
          ),
          settings: settings,
        );
      case AppRoutes.addPaymentCard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) {
                final paymentCubit = PaymentCubit();
                return paymentCubit;
              },
              child: const AddPaymentCard()),
          settings: settings,
        );
      case AppRoutes.payment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) {
                final paymentCubit = PaymentCubit();
                paymentCubit.getPaymentViewData();
                return paymentCubit;
              },
              child: const PaymentPage()),
          settings: settings,
        );
      case AppRoutes.bottomNavbar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final authCubit = AuthCubit();
              authCubit.getCurrentUserData();
              return authCubit;
            },
            child: const CustomBottomNavbar(),
          ),
          settings: settings,
        );
      case AppRoutes.homeLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case AppRoutes.createAccount:
        return MaterialPageRoute(
          builder: (_) => const CreateAccountPage(),
          settings: settings,
        );
      case AppRoutes.emailVerification:
       final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EmailVerificationPage(email: email,),
          settings: settings,
        );
      case AppRoutes.onboardingPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final onboardingCubit = OnboardingCubit();
              onboardingCubit.getOnboardingData();
              return onboardingCubit;
            },
            child: const OnBoardingPage(),
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
