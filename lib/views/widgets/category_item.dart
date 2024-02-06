import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/models/category_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class CategoryItem extends StatelessWidget {
  
  final CategoryItemModel categoryItem;

  const CategoryItem({super.key,required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children:[
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
                imageUrl: categoryItem.imgUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
         Align(
            alignment: (categoryItem.id % 2) == 0 ? Alignment.centerRight: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                width: 120,
                blur: 4,
                color: Colors.black.withOpacity(0.8),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black45.withOpacity(0.7),
                    Colors.white.withOpacity(0.8),
                  ],
                ),
                //--code to remove border
                border: const Border.fromBorderSide(BorderSide.none),
                shadowStrength: 5,
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(10),
                shadowColor: Colors.black.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        categoryItem.name,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${categoryItem.productsCount} Product',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}