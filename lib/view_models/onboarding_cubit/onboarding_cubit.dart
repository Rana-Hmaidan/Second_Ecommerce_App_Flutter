
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/onboarding_model.dart';
import 'package:second_ecommerce_app_flutter/services/auth_services.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final authServices = AuthServicesImpl();
  
  Future<void> addOnboarding(OnboardingModel onboarding) async{
    await authServices.addOnbordingItem(onboarding);
  }

  Future<void> getOnboardingData() async {
    emit(OnboardingLoading());
    try {
      final onboardingItems = await authServices.getOnbordingItems();
      emit(OnboardingLoaded(onboardingItems));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

}
