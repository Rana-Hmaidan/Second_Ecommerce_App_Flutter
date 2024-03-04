import 'package:second_ecommerce_app_flutter/models/payment_method_model.dart';
import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';
//import 'package:second_ecommerce_app_flutter/models/location_model.dart';

abstract class PaymentServices {
  Future<List<PaymentMethodModel>> getPayments(String uid , {bool hasQuery = false});
  Future<void> addPaymentMethod(String uid, PaymentMethodModel paymentMethod);
  Future<void> setPaymentMethod(String uid , PaymentMethodModel paymentMethod);
  Future<void> unSetPaymentMethod(String uid , PaymentMethodModel paymentMethod);
}

class PaymentServicesImpl implements PaymentServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<PaymentMethodModel>> getPayments(String uid , {bool hasQuery = false}) async {
    return await firestoreService.getCollection(
      path: ApiPaths.payments(uid),
      builder: (data, documentId) => PaymentMethodModel.fromMap(data, documentId),
      queryBuilder: hasQuery ? (query) => query.where('isSelected', isEqualTo: true) : null,
    );
  }

  @override
 Future<void> addPaymentMethod(String uid, PaymentMethodModel paymentMethod) async => 
    await firestoreService.setData(path: ApiPaths.payment(uid, paymentMethod.id), data: paymentMethod.toMap());

  
  @override
  Future<void> setPaymentMethod(String uid , PaymentMethodModel paymentMethod) async {
    await firestoreService.setData(
        path: ApiPaths.payment(uid, paymentMethod.id),
        data: paymentMethod.copyWith(isSelected: true).toMap(),
      );
  }

  @override
  Future<void> unSetPaymentMethod(String uid , PaymentMethodModel paymentMethod) async {
    await firestoreService.setData(
        path: ApiPaths.location(uid, paymentMethod.id),
        data: paymentMethod.copyWith(isSelected: false).toMap(),
      );
  }
}