part of 'onboarding_cubit.dart';

sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {

  final List<OnboardingModel> onboardingItems;
  
  OnboardingLoaded(this.onboardingItems);
}

final class OnboardingError extends OnboardingState {
  final String message;
  OnboardingError(this.message);
}