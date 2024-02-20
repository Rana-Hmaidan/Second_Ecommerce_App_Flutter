import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/counter_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoaded ||
          current is ProductDetailsError ||
          current is ProductDetailsLoading || 
          current is QuantityCounterLoading,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              actions: [
                IconButton(
                  onPressed: () async => await cubit.addToFavorites(product.id),
                  icon: Icon(product.isFavorite == false? Icons.favorite_border : Icons.favorite),
                  color: AppColors.red,
                ),
              ],
            ),
            body: SafeArea(
              top: false,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.6,
                    // padding: EdgeInsets.only(top: size.height * 0.09),
                    decoration: BoxDecoration(
                      color: AppColors.grey2,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.imgUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.38),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: AppColors.orange,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        product.averageRate.toString(),
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (state is QuantityCounterLoaded)...[
                                  CounterWidget(
                                    cubit: cubit,
                                    counter: product.quantity ,
                                    productItem: product,
                                  ),
                              ]else ...[
                                  CounterWidget(
                                    cubit: cubit,
                                    counter: 1,
                                    productItem: product,
                                  ),
                                ],
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Size',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: ProductSize.values
                                .map( (size) => BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                                    bloc: cubit,
                                    buildWhen: (previous, current) => current is SizeChanged,
                                    builder: (context, state) {
                                      if (state is SizeChanged) {
                                        final selectedSize = state.size;
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.only(end: 8.0),
                                          child: InkWell(
                                            onTap: () => cubit.changeSize(size),
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor: selectedSize == size
                                                      ? Theme.of(context).primaryColor
                                                      : AppColors.grey2,
                                              child: Center(
                                                child: Text(
                                                  size.name,
                                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: selectedSize == size
                                                            ? AppColors.white
                                                            : null,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.only(end: 8.0),
                                          child: InkWell(
                                            onTap: () => cubit.changeSize(size),
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor: AppColors.grey2,
                                              child: Center(
                                                child: Text(
                                                  size.name,
                                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Details',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.grey,
                            ),
                            maxLines: 5,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$ ${(product.price * product.quantity).toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                                  bloc: cubit,
                                  listenWhen: (previous, current) => current is AddToCartError,
                                  listener: (context, state) {
                                    if (state is AddToCartError) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Alert!'),
                                            content: const Text('You must select a size before adding to cart!'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  buildWhen: (previous, current) =>
                                      current is AddingToCart ||
                                      current is AddedToCart ||
                                      current is AddToCartError,
                                  builder: (context, state) {
                                    if (state is AddingToCart) {
                                      return ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: AppColors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                  BorderRadius.circular(16))),
                                        child: const CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    } else if (state is AddedToCart) {
                                      return ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: AppColors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16))),
                                        child: const Text('Added'),
                                      );
                                    } else {
                                      return ElevatedButton(
                                        onPressed: () async => await cubit.addToCart(product.id),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: AppColors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16))
                                            ),
                                        child: const Text('Add to Order'),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error Page!'),
            ),
          );
        }
      },
    );
  }
}