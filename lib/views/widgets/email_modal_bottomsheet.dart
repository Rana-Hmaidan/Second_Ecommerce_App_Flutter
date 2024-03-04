import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';
import 'package:second_ecommerce_app_flutter/views/widgets/main_button.dart';

class EmailModalBottomsheet extends StatelessWidget {
  const EmailModalBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
      return SizedBox(
      height: 350,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 35),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromARGB(255, 102, 201, 118),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check, 
                    color: AppColors.white
                  ),
                ),
              ),
              Text(
                'Register Success',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Congratulations! your account already created.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Please login to get amazing experience.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 30.0),
              MainButton(
                title: 'Go to Homepage',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.homeLogin);
                },
              ),
          ],
        ),
      ),
    );
  }
}