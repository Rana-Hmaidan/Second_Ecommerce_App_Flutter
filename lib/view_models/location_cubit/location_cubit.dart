import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/location_model.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';
import 'package:second_ecommerce_app_flutter/services/location_services.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final locationServices = LocationServicesImpl();
  final authServices = AuthServicesImpl();

  // Future<void> addLocation(LocationModel location) async{
  //   final currentUser = await authServices.currentUser();
  //   await locationServices.addLocation(currentUser!.uid, location);
  // }

  void getLocations() async {
    emit(LocationLoading());
    try {
      final currentUser = await authServices.currentUser();
      final locations = await locationServices.getLocations(currentUser!.uid);
      emit(LocationSuccess(
        locations: locations,
      ));
    } catch (e) {
      emit(
        LocationFailed(message: e.toString()),
      );
    }
  }

  Future<void> setLocationItem(LocationModel location) async {
    try {
      emit(LocationLoading());
      final currentUser = await authServices.currentUser();
      final selectedLocations = await locationServices.getLocations(currentUser!.uid, hasQuery: true);
      if (selectedLocations.isNotEmpty) {
        await locationServices.unSetLocationItem(currentUser.uid, selectedLocations.first);
      }
      await locationServices.setLocationItem(currentUser.uid, location);
      final locations = await locationServices.getLocations(currentUser.uid);
      emit(LocationSet());
      emit(LocationSuccess(locations: locations));
    } catch (e) {
      emit(
        LocationFailed(message: e.toString()),
      );
    }
  }
}