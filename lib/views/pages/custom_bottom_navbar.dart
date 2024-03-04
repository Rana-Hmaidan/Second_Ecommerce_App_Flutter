import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
//import 'package:second_ecommerce_app_flutter/utils/app_assets.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/view_models/auth_cubit/auth_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/cart_cubit/cart_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/profile_cubit/profile_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/pages/cart_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/favorites_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/home_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/profle_page.dart';
import 'package:second_ecommerce_app_flutter/views/pages/search_page.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late PersistentTabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _controller = PersistentTabController();
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      BlocProvider(
        create: (context) {
          final cubit = FavoritesCubit();
          cubit.getFavoritesItems();
          return cubit;
        },
        child: const FavoritesPage(),
      ),
      BlocProvider(
        create: (context) {
          final cubit = CartCubit();
          cubit.getCartItems();
          return cubit;
        },
        child: const CartPage(),
      ),
      // BlocProvider(
      //   create: (context) {
      //     final cubit = ProfileCubit();
      //     cubit.getUserProfile();
      //     return cubit;
      //   },
      //   child: const ProfilePage(),
      // ),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.home_outlined),
        icon: const Icon(Icons.home_filled),
        title: "Home",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.favorite_border),
        icon: const Icon(Icons.favorite),
        title: "Favorites",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.shopping_cart_outlined),
        icon: const Icon(Icons.shopping_cart),
        title: "Cart",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.person_outline),
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<AuthCubit>(context);

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: cubit,
      buildWhen: (previous, current) => 
        current is AuthLoaded,
      builder: (context, state) {
        if(state is AuthLoaded){
        final user = state.user;
        return Scaffold(
          appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.imgUrl),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ${user.username}',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Let\'s go shopping!',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                ],
              ),
              centerTitle: false,
              actions: [
                if (_currentIndex == 0) ...[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const SearchPage()));
                    },
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
                if (_currentIndex == 1) ...[
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: TextButton.icon(
                      onPressed: () {},
                      label: const Text('My Orders'),
                      icon: const Icon(Icons.shopping_bag),
                    ),
                  ),
                ],
                if (_currentIndex == 2) ...[
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                    ),
                  ),
                ]
              ]),
          body: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style3, // Choose the nav bar style with this property.
          ),
        );
        }else{
          return const SizedBox.shrink();
        }
      },
    );
  }
}
