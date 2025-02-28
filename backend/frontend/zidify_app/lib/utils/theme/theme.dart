import 'package:flutter/material.dart';
import 'package:zidify_app/utils/theme/custom/appbar_theme.dart';
import 'package:zidify_app/utils/theme/custom/checkbox_theme.dart';
import 'package:zidify_app/utils/theme/custom/chip_theme.dart';
import 'package:zidify_app/utils/theme/custom/elevated_button_theme.dart';
import 'package:zidify_app/utils/theme/custom/outlined_button_theme.dart';
import 'package:zidify_app/utils/theme/custom/text_field_theme.dart';
import 'package:zidify_app/utils/theme/custom/text_theme.dart';

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
