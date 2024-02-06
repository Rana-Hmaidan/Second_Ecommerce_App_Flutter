import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      useMaterial3: true,
    );
  }
}