import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/favorite_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:second_ecommerce_app_flutter/view_models/home_cubit/home_cubit.dart';

class FavoriteItem extends StatelessWidget {

  final FavoriteItemModel favoriteItem;
  
  const FavoriteItem({super.key, required this.favoriteItem});

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<FavoritesCubit>(context);

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
                  imageUrl: favoriteItem.product.imgUrl,
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
                child: IconButton(
                  onPressed: () async => await cubit.removeFromFavorites(favoriteItem),
                  icon: const Icon(
                    Icons.favorite,
                    color: AppColors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          favoriteItem.product.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          favoriteItem.product.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
        Text(
          '\$${favoriteItem.product.price}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}