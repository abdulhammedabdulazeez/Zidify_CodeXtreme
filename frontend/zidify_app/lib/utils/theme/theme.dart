import 'package:flutter/material.dart';
import '../constants/theme/custom_themes/text_theme.dart';
import '../constants/theme/custom_themes/appbar_theme.dart';
import '../constants/theme/custom_themes/checkbox_theme.dart';
import '../constants/theme/custom_themes/chip_theme.dart';
import '../constants/theme/custom_themes/elevated_button_theme.dart';
import '../constants/theme/custom_themes/outlined_button_theme.dart';
import '../constants/theme/custom_themes/text_field_theme.dart';

class AGAppTheme {
  AGAppTheme._();

  /// LIGHT APP THEME
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(56, 28, 114, 1),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );

  /// DARK APP THEME
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color.fromRGBO(56, 28, 114, 1),
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    appBarTheme: AppAppBarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
  );
}
