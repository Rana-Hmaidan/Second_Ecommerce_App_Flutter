import 'package:second_ecommerce_app_flutter/services/firestore_services.dart';
import 'package:second_ecommerce_app_flutter/utils/api_paths.dart';
import 'package:second_ecommerce_app_flutter/models/location_model.dart';

abstract class LocationServices {
  Future<List<LocationModel>> getLocations(String uid , {bool hasQuery = false});
  Future<void> addLocation(String uid,LocationModel location);
  Future<void> setLocationItem(String uid , LocationModel location);
  Future<void> unSetLocationItem(String uid, LocationModel location);
}

class LocationServicesImpl implements LocationServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<LocationModel>> getLocations(String uid , {bool hasQuery = false}) async {
    return await firestoreService.getCollection(
      path: ApiPaths.locations(uid),
      builder: (data, documentId) => LocationModel.fromMap(data, documentId),
      queryBuilder: hasQuery ? (query) => query.where('isSelected', isEqualTo: true) : null,
    );
  }

  @override
  Future<void> addLocation(String uid,LocationModel location) async => 
    await firestoreService.setData(path: ApiPaths.location(uid, location.id), data: location.toMap());

  
  @override
  Future<void> setLocationItem(String uid , LocationModel location) async {
    await firestoreService.setData(
        path: ApiPaths.location(uid, location.id),
        data: location.copyWith(isSelected: true).toMap(),
      );
  }

  @override
  Future<void> unSetLocationItem(String uid, LocationModel location) async {
    await firestoreService.setData(
        path: ApiPaths.location(uid, location.id),
        data: location.copyWith(isSelected: false).toMap(),
      );
  }
}