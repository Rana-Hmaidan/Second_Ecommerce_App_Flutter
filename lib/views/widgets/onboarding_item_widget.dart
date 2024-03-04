import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/models/onboarding_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class OnboardingItemWidget extends StatelessWidget {

  final OnboardingModel onboardingItem;

  const OnboardingItemWidget({super.key, required this.onboardingItem});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              width: 300,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: AppColors.grey1,
              ),
              child: CachedNetworkImage(
                imageUrl: onboardingItem.imgUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 14.0,),
          Text(
            onboardingItem.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          const SizedBox(height: 14.0,),
          Text(
            onboardingItem.description,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
             color: Colors.grey,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}