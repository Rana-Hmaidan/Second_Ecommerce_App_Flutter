import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class CategoryChipWidget extends StatelessWidget {

  const CategoryChipWidget({super.key, required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      labelStyle:  TextStyle(
          color: isSelected? AppColors.white : AppColors.black87,
      ),
      selected: isSelected,
      onPressed: onTap,
      showCheckmark: false,
      backgroundColor: AppColors.grey2,
      selectedColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: AppColors.grey),
      ),
    );
  }
}