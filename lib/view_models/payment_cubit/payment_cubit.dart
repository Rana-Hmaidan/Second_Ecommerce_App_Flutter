import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/payment_method_model.dart';
import 'package:second_ecommerce_app_flutter/models/location_model.dart';
import 'package:second_ecommerce_app_flutter/models/cart_orders_model.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:second_ecommerce_app_flutter/services/cart_services.dart';
import 'package:second_ecommerce_app_flutter/services/location_services.dart';
import 'package:second_ecommerce_app_flutter/services/payment_services.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState>{

  PaymentCubit() : super(PaymentInitial());
    
    final authServices = AuthServicesImpl();
    final cartServices = CartServicesImpl();
    final locationServices = LocationServicesImpl();
    final paymentServices = PaymentServicesImpl();

  Future<void> getPaymentViewData() async {
    emit(PaymentLoading());
    try {
      final currentUser = await authServices.currentUser();
      
      final cartItems = await cartServices.getCartItems(currentUser!.uid);

      final subTotal = cartItems.fold<double>(0, (sum, item) => sum + (item.product.price * item.quantity));
      
      final selectedLocation = (await locationServices.getLocations(currentUser.uid, hasQuery: true)).isNotEmpty 
                                ? (await locationServices.getLocations(currentUser.uid, hasQuery: true)).first 
                                : null;
      final selectedPaymentMethod = (await paymentServices.getPayments(currentUser.uid,hasQuery: true)).isNotEmpty
                                ? (await paymentServices.getPayments(currentUser.uid, hasQuery: true)).first
                                : null;
      emit(PaymentLoaded(
        cartItems: cartItems,
        total: subTotal + 10,
        location: selectedLocation,
        paymentMethod: selectedPaymentMethod,
      ));
    } catch (e) {
      emit(
        PaymentError(message: e.toString()),
      );
    }
  }

  Future<void> setPaymentMethodItem(PaymentMethodModel paymentMethod) async {
    try {
      emit(PaymentMethodLoading());
      final currentUser = await authServices.currentUser();
      final selectedPaymentMethods = await paymentServices.getPayments(currentUser!.uid, hasQuery: true);
      if (selectedPaymentMethods.isNotEmpty) {
        await paymentServices.unSetPaymentMethod(currentUser.uid, selectedPaymentMethods.first);
      }
      await paymentServices.setPaymentMethod(currentUser.uid, paymentMethod);
      final payments = await paymentServices.getPayments(currentUser.uid);
      emit(PaymentSet());
      emit(PaymentMethodSuccess(payments: payments));
    } catch (e) {
      emit(
        PaymentError(message: e.toString()),
      );
    }
  }

  Future<void> addNewPaymentMethod(PaymentMethodModel paymentMethod) async {
    emit(AddingNewPayments());
    try {
      final currentUser = await authServices.currentUser();
      await paymentServices.addPaymentMethod(currentUser!.uid, paymentMethod);
      emit(AddedNewPayments());
    } catch (e) {
      emit(AddNewPaymentsError(e.toString()));
    }
  }

  // void choosePaymentMethod(String paymentMethodId){
  //   emit(PaymentMethodChosen(paymentMethodId: paymentMethodId));
  // }

  // void addNewPaymentMethod(PaymentMethodModel newPaymentMethodItem ){
  //   savedCards.add(newPaymentMethodItem);
  // }

}