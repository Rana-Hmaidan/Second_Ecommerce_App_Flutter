import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({super.key, required this.leadingIcon, required this.title, required this.onTapItem});

  final IconData leadingIcon;
  final String title;
  final VoidCallback onTapItem;

  @override
  Widget build(BuildContext context) {
   return Card(
     color: AppColors.white ,
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
              onTap: onTapItem, 
              leading:  Icon(
                leadingIcon, 
                size: 30,
                color: AppColors.black,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, 
                color: title == 'Logout' ? AppColors.red : AppColors.black,
                size: 18,
              ),
            ),
     ),
   );
  }
}