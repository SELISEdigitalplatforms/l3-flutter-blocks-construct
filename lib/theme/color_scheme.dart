import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';

var lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary50,
  onPrimary: Color(0xFFE0F1F2),
  primaryContainer: Color(0xFFB1DCDE),
  onPrimaryContainer: Color(0xFF084742),
  secondary: Color(0xFF349DD8),
  onSecondary: Color(0xFFE1F3FB),
  secondaryContainer: AppColors.neutral100,
  onSecondaryContainer: AppColors.neutral40,
  error: AppColors.error50,
  onError: AppColors.error40,
  errorContainer: Color(0xFFFCEBEC),
  onErrorContainer: Color(0xFF2C0B0E),
  surface: AppColors.neutral50,
  onSurface: AppColors.neutral10,
  surfaceContainerHighest: Color(0xFFE9E9E9),
  onSurfaceVariant: AppColors.neutral80,
  outline: Color(0xFF7B7B7B),
  outlineVariant: Color(0xFFC4C4C4),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF000000),
  onInverseSurface: Color(0xFFF5F5F5),
  inversePrimary: Color(0xFF7FC7C8),
  surfaceTint: Color(0xFF008F8D),
  tertiary: AppColors.success30,                    //Success
  onTertiary: AppColors.success20,                  //onSuccess
  tertiaryContainer: AppColors.success60,                   //SuccessBackground
);

var darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primaryDark50,
  onPrimary: Color(0xFFDFEFF1),
  primaryContainer: Color(0xFFB1DCDE),
  onPrimaryContainer: Color(0xFF084742),
  secondary: Color(0xFF349DD8),
  onSecondary: Color(0xFFE1F3FB),
  secondaryContainer: AppColors.neutral20,
  onSecondaryContainer: AppColors.neutral100,
  error: AppColors.error10,
  onError: AppColors.error30,
  errorContainer: Color(0xFFFCEBEC),
  onErrorContainer: Color(0xFF2C0B0E),
  surface: AppColors.neutral30,
  onSurface: AppColors.neutral100,
  surfaceContainerHighest: Color(0xFFE9E9E9),
  onSurfaceVariant: AppColors.neutral80,
  outline: Color(0xFF7B7B7B),
  outlineVariant: Color(0xFFC4C4C4),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF000000),
  onInverseSurface: Color(0xFFF5F5F5),
  inversePrimary: Color(0xFF7FC7C8),
  surfaceTint: Color(0xFF008F8D),
  tertiary: AppColors.success40,                  //Success
  onTertiary: AppColors.success50,                  //onSuccess
  tertiaryContainer: AppColors.success10,                 //SuccessBackground
);
