import 'package:flutter/material.dart';
import 'package:task_trekker/core/theme/text_theme.dart';
import 'app_colors.dart';

final ThemeData themeData = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.primary,
    secondary: AppColors.lightGrey,
    surface: AppColors.lightGrey,
    error: AppColors.error,
    onPrimary: AppColors.primary,
    onSecondary: AppColors.lightGrey,
    onSurface: AppColors.lightGrey,
    onError: AppColors.error,
    brightness: Brightness.light,
  ),
  fontFamily: "Roboto",
  textTheme: textTheme,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
);
