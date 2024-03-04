part of 'payment_cubit.dart';

sealed class PaymentState {
  const PaymentState();
}

final class PaymentInitial extends PaymentState{}

final class PaymentLoading extends PaymentState{}

final class PaymentLoaded extends PaymentState{

  List<CartOrdersModel> cartItems;
  final double total;
  final LocationModel? location;
  final PaymentMethodModel? paymentMethod;

  PaymentLoaded({
    required this.cartItems,
    required this.total,
    this.location,
    this.paymentMethod,
  });
}

final class PaymentMethodLoading extends PaymentState{}

final class PaymentMethodSuccess extends PaymentState {
  final List<PaymentMethodModel> payments;

  PaymentMethodSuccess({
    required this.payments,
  });
}

final class PaymentSet extends PaymentState {
  PaymentSet();
}

final class PaymentError extends PaymentState{
  final String message;

  const PaymentError({
    required this.message
  });
}

final class AddingNewPayments extends PaymentState {}

final class AddedNewPayments extends PaymentState {}

final class AddNewPaymentsError extends PaymentState {
  final String message;

  AddNewPaymentsError(this.message);
}

// final class PaymentMethodChosen extends PaymentState{
//   final String paymentMethodId;

//   const PaymentMethodChosen({
//     required this.paymentMethodId
//   });
// }

