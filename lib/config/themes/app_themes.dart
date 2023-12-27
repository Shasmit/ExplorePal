import 'package:exploree_pal/config/constants/app_color_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();
  static getApplicationTheme() {
    return ThemeData(
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppColors.buttonColors),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
