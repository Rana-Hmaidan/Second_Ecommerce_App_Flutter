import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class LastSearchItem extends StatelessWidget {
  final String value;
  final VoidCallback onPressed;
  final VoidCallback onPresseedIcon;

  const LastSearchItem({super.key, required this.value, required this.onPressed, required this.onPresseedIcon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          side: const BorderSide(
            color: AppColors.grey,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          alignment: Alignment.center,
          foregroundColor: AppColors.grey,
          backgroundColor: AppColors.white,
        ), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value),
            const SizedBox(width: 2,),
            IconButton(icon: const Icon(Icons.clear), onPressed: onPresseedIcon,),
          ],
        ),
    );
  }
}