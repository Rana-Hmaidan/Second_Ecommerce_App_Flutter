import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/payment_method_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/view_models/payment_cubit/payment_cubit.dart';

class PaymentItemWidget extends StatelessWidget {
  
  final PaymentMethodModel? paymentMethod;
  final VoidCallback? additionOnTap;

  const PaymentItemWidget({
    super.key,
    this.paymentMethod,
    this.additionOnTap,
    });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentCubit>(context);

            return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: additionOnTap != null && paymentMethod == null 
                      ? additionOnTap 
                      : (){
                        cubit.setPaymentMethodItem(paymentMethod!);
                      },
                      leading: paymentMethod == null ? const Icon(Icons.add) : ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: CachedNetworkImage(
                          imageUrl: paymentMethod!.imgUrl,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      title: Text(
                        paymentMethod != null ? paymentMethod!.name : 'Add Payment Method',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: paymentMethod != null ? Text(
                        paymentMethod!.cardNumber,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                      ) : null,
                      trailing: paymentMethod != null 
                      ? BlocBuilder<PaymentCubit, PaymentState>(
                        bloc: cubit,
                        buildWhen: (previous, current) => 
                          current is PaymentMethodSuccess,
                        builder: (context, state) {
                          return Radio<PaymentMethodModel>(
                            value: paymentMethod!, 
                            groupValue: state is PaymentMethodSuccess ? state.payments.first : null, 
                            onChanged: (value) => cubit.setPaymentMethodItem(value!),
                           );
                        }
                      ) 
                      : null,
                    ),
                  ),
                ),
              );
  }
}