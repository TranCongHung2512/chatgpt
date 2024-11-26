import 'package:client/design/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBgColor, // Màu nền cho AppBar
      elevation: 0, // Loại bỏ bóng của AppBar
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBgColor, // Màu nền cho Scaffold
  );
}
