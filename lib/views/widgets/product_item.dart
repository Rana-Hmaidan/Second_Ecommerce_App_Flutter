import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
//import 'package:second_ecommerce_app_flutter/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/home_cubit/home_cubit.dart';

class ProductItem extends StatelessWidget {

  final ProductItemModel productItem;
  
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<HomeCubit>(context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.grey2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 6.0,
              right: 8.0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                    current is AddingToFavorites ||
                    current is AddedToFavorites ||
                    current is AddToFavoritesError,
                  builder: (context, state) {
                    if(state is AddingToFavorites){
                      return const CircularProgressIndicator.adaptive();
                    } else if(state is AddedToFavorites){
                      return IconButton(
                        onPressed: () async => await cubit.removeFromFavorites(productItem.id),
                        icon: const Icon(
                          Icons.favorite,
                          color: AppColors.red,
                        ),
                      );
                    } else{
                      return IconButton(
                        onPressed: () async => await cubit.addToFavorites(productItem.id),
                        icon: const Icon(
                          Icons.favorite_border,
                          color: AppColors.red,
                        ),
                      );
                    }
                  },
                ),
                // BlocBuilder<FavoritesCubit, FavoritesState>(
                //   builder: (context, state) {
                //     final isFavorite = BlocProvider.of<FavoritesCubit>(context).favoriteProducts[productItem.id] ?? false;
                //     final isLoading = BlocProvider.of<FavoritesCubit>(context).loadingProducts[productItem.id] ?? false;

                //     return IconButton(
                //       onPressed: (){
                //         if(isFavorite){
                //            BlocProvider.of<FavoritesCubit>(context).deleteFavorite(productItem.id);
                //         }else{
                //           BlocProvider.of<FavoritesCubit>(context).addFavorite(productItem.id);
                //         }
                //       },
                //       icon: isLoading? const CircularProgressIndicator.adaptive() :  Icon(
                //         isFavorite? Icons.favorite : Icons.favorite_border,
                //         color: isFavorite? AppColors.red : null,
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          productItem.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          productItem.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
        Text(
          '\$${productItem.price}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

                  // builder: (context, state) {
                  //   return IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         if (favProducts.contains(widget.productItem)) {
                  //           favProducts.remove(widget.productItem);
                  //         } else {
                  //           favProducts.add(widget.productItem);
                  //         }
                  //       });
                  //     },
                  //     icon: Icon(
                  //       favProducts.contains(widget.productItem)
                  //           ? Icons.favorite
                  //           : Icons.favorite_border,
                  //       color: AppColors.orange,
                  //     ),
                  //   );
                  // },