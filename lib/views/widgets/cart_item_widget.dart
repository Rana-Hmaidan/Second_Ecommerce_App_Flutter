import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/product_item_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/view_models/cart_cubit/cart_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/counter_widget.dart';

class CartItemWidget extends StatelessWidget {

  final ProductItemModel productItem;

  const CartItemWidget({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8.0),
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0) ,
                    child: CachedNetworkImage(
                      imageUrl: productItem.imgUrl ,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                PositionedDirectional(
                  end: 8,
                  top: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => cartCubit.removeFromCart(productItem.id),
                      icon: const Icon(Icons.delete_outline, size: 30,),
                      color: AppColors.red,
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 8,
                  bottom: 8,
                  child: BlocBuilder<CartCubit, CartState>(
                    bloc: cartCubit,
                    buildWhen: (previous, current) => (current is QuantityCounterLoaded && current.productId == productItem.id ) || current is CartLoaded,
                    builder: (context, state) {
                      if(state is QuantityCounterLoaded) {
                        return CounterWidget(
                        cubit: BlocProvider.of<CartCubit>(context),
                        counter: state.value,
                        productItem: productItem,
                      );
                      }else if(state is CartLoaded){
                        return CounterWidget(
                          cubit: BlocProvider.of<CartCubit>(context), 
                          counter: state.cartItems.firstWhere((item) => item.id == productItem.id).quantity,
                          productItem: productItem,
                        );
                      }
                      else{
                        return const SizedBox();
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(
                    productItem.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600
                    ),
                 ),
                 if(productItem.size != null)
                 Text.rich(
                  TextSpan(
                    text: 'Size: ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: productItem.size?.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ]
                  ),
                 )
                ],
              ),
              Text(
                '\$${(productItem.price * productItem.quantity).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}