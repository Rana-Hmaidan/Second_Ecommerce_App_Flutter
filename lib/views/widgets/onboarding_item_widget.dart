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
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
                height: 250,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.grey2,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CachedNetworkImage(
                    imageUrl: onboardingItem.imgUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                )
              ),
          const SizedBox(height: 10.0,),
          Text(
            onboardingItem.title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0,),
          Text(
            onboardingItem.description,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
             color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}