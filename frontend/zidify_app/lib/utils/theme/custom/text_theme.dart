import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  /// LIGHT TEXT THEME
  static TextTheme lightTextTheme = TextTheme(
    /// HEADLINE TEXT THEME
    headlineLarge: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 700),
          const FontVariation('opsz', 32.0)
        ],
        color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 700),
          const FontVariation('opsz', 24.0)
        ],
        color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 600),
          const FontVariation('opsz', 18.0)
        ],
        color: Colors.black),

    /// TITLE TEXT THEME
    titleLarge: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 600),
          const FontVariation('opsz', 16.0)
        ],
        color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 500),
          const FontVariation('opsz', 16.0)
        ],
        color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 400),
          const FontVariation('opsz', 16.0)
        ],
        color: Colors.black),

    /// BODY TEXT THEME
    bodyLarge: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 600),
          const FontVariation('opsz', 14.0)
        ],
        color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 500),
          const FontVariation('opsz', 14.0)
        ],
        color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 400),
          const FontVariation('opsz', 14.0)
        ],
        color: Colors.black.withOpacity(0.5)),

    /// LARGE TEXT THEME
    labelLarge: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 400),
          const FontVariation('opsz', 12.0)
        ],
        color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontFamily: 'BricolageGrotesque',
        fontVariations: [
          const FontVariation('wght', 400),
          const FontVariation('opsz', 12.0)
        ],
        color: Colors.black.withOpacity(0.5)),
  );

  /// DARK TEXT THEME
  static TextTheme darkTextTheme = TextTheme(
    /// HEADLINE TEXT THEME
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),

    /// TITLE TEXT THEME
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),

    /// BODY TEXT THEME
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.5)),

    /// LARGE TEXT THEME
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5)),
  );
}
