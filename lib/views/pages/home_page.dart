import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/categories_tab_view.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/home_tab_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Categories',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                HomeTabView(),
                CategoriesTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}