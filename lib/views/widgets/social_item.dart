import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class SocialItem extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  final IconData? actionIcon;

  const SocialItem({
    super.key, 
    required this.icon, 
    required this.title, 
    required this.onTap, 
    required this.color, 
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.grey3
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color,),
              const SizedBox(width: 16.0,),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16.0,),
              if (actionIcon != null) Icon(actionIcon, color: AppColors.grey3,) else const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}