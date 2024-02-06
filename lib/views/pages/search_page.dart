import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/models/search_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/last_search_item.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/popular_search_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          }, 
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const SizedBox(width: 6),
                        SizedBox(
                          width: 400,
                          height: 50,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => _searchController.clear(),
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {},
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0), 
                              ),
                              prefixIconColor: AppColors.black,
                              suffixIconColor: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Last Search',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: (){},
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ), 
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: dummylastSearches.map((item) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Expanded(
                              child: LastSearchItem(
                                      value: item, 
                                      onPressed: () {  }, 
                                      onPresseedIcon: () {  },
                                    ),
                              ),
                            ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                      const SizedBox(height: 24,),
                      Text(
                          'Popular Search',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemCount: dummyPopularSearches.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (_, index) => const SizedBox(height: 10.0),
                          itemBuilder: (context, index) => PopularSearchItem(
                            searchItem: dummyPopularSearches[index],
                          ),
                        ),
                      ),
                  ]
                ),
              ),
            ),
      ),
    );
  }
}