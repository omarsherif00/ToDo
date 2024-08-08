import 'package:flutter/material.dart';
import 'package:todo/utilties/AppColors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
      scaffoldBackgroundColor: AppColors.PrimaryLight,
      canvasColor: Colors.white,
      appBarTheme:
          const AppBarTheme(backgroundColor: AppColors.secondryLight, elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: AppColors.grey,
          selectedItemColor: AppColors.secondryLight,
          selectedIconTheme: IconThemeData(size: 33),
          unselectedIconTheme: IconThemeData(size: 33)
      ,elevation: 15));

  static ThemeData dark = ThemeData();
}
