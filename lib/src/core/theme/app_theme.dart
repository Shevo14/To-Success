import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();

  ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF4F46E5),
      brightness: Brightness.light,
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(centerTitle: true),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF6366F1),
      brightness: Brightness.dark,
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(centerTitle: true),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class ThemeBundle {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  const ThemeBundle({required this.lightTheme, required this.darkTheme});
}

final appThemeProvider = Provider<ThemeBundle>((ref) {
  const appTheme = AppTheme();
  return ThemeBundle(lightTheme: appTheme.lightTheme, darkTheme: appTheme.darkTheme);
});