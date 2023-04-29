import 'package:flutter/material.dart';
import 'package:shady_ai/themes/color_schemes.dart';

ThemeData get m3DarkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      splashFactory: NoSplash.splashFactory,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
      ),
    );
