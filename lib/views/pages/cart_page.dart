import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/view_models/cart_cubit/cart_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CartCubit, CartState>(
      bloc: BlocProvider.of<CartCubit>(context),
      buildWhen:(previous, current) => current is! QuantityCounterLoaded,
      builder: (context, state) {
        if(state is CartLoading){
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }else if(state is CartError){
          return Center(
            child: Text(state.message),
          );
        }else if(state is CartLoaded){
          return Column(
            children: [           
              SizedBox(
                width: double.infinity,
                height: size.height * 0.42,
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    final item = state.cartItems[index];
                    return CartItemWidget(productItem: item);
                  },
                ),
              ),
              //const SizedBox(height: 24,),
              Container(
               width: double.infinity,
               height: size.height * 0.4,
                padding: const EdgeInsets.all(30),
                decoration:  BoxDecoration(
                  color: AppColors.grey2,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
              child: Column(
                children: [
                  buildTotalAndSubtotalItem(context, 'Subtotal', state.subtotal),
                  const SizedBox(height: 10,),
                  buildTotalAndSubtotalItem(context, 'Shipping', 10),
                  const SizedBox(height: 16,),
                  Dash(
                    length: size.width-65, 
                    dashLength: 10,
                    dashColor: AppColors.grey,
                  ),
                  const SizedBox(height: 16,),
                  buildTotalAndSubtotalItem(context, 'Total Amount', state.subtotal + 10),
                  const SizedBox(height: 36,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: AppColors.white,
                      ), 
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ); 
        }else{
          return const SizedBox();
        }
      }
    );
  }

  Widget buildTotalAndSubtotalItem(BuildContext context, String title, double value){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppColors.grey,
            ),
          ),
          Text(
            '\$$value',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
