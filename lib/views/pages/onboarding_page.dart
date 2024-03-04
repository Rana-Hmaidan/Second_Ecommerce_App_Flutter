import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_ecommerce_app_flutter/models/onboarding_model.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/view_models/onboarding_cubit/onboarding_cubit.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/onboarding_item_widget.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  late CarouselController _controller;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  // final List<Widget> onboardingSliders = dummyOnboardingItems
  //     .map((item) => OnboardingItemWidget(onboardingItem: item,))
  //     .toList();

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<OnboardingCubit>(context);

    // for(final onboardingItem in dummyOnboardingItems){
    //   cubit.addOnboarding(onboardingItem);
    // }
  
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      bloc: cubit,
      buildWhen: (previous, current) => 
        current is OnboardingLoaded || 
        current is OnboardingLoading ||
        current is OnboardingError,
      builder: (context, state) {
        if(state is OnboardingLoading){
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if(state is OnboardingLoaded){
          final onboardingItems = state.onboardingItems;
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CarouselSlider(
                    //items: onboardingSliders,
                    items: onboardingItems.map(
                      (item) => OnboardingItemWidget( onboardingItem: item,)
                    ).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: onboardingItems.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Theme.of(context).primaryColor)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.createAccount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: AppColors.white,
                ),
                child: Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.homeLogin);
                },
                child: Text(
                  'Already Have an Account',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
            ],
          ),
        );
        }else{
          return const SizedBox();
        }
      },
    );
  }
}
