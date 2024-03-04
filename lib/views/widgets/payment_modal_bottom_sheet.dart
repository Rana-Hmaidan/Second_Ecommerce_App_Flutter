import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:second_ecommerce_app_flutter/models/payment_method_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/payment_cubit/payment_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/payment_item_widget.dart';

class PaymentModalBottomSheet extends StatelessWidget {
  final dynamic cubit;
  const PaymentModalBottomSheet({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16.0,
            ),
            BlocConsumer<PaymentCubit, PaymentState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                    current is PaymentMethodSuccess ||
                    current is PaymentMethodLoading ||
                    current is PaymentError,
                listenWhen: (previous, current) => current is PaymentSet,
                listener: (context, state) {
                  if (state is PaymentSet) {
                    Navigator.of(context).pop();
                  }
                },
              builder: (context, state) {
                if (state is PaymentMethodLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 170.0, vertical: 18),
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is PaymentMethodSuccess) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.payments.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PaymentItemWidget(
                            paymentMethod: state.payments[index],
                        );
                    });
                  } else if (state is PaymentError) {
                      return Text(state.message);
                  } else {
                    return const SizedBox.shrink();
                  }
              },
            ),
            PaymentItemWidget(
              additionOnTap: () => Navigator.of(context).pushNamed(AppRoutes.addPaymentCard),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: AppColors.white,
                  ),
                  child: const Text(
                    'Confirm Payment',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
