import 'package:flutter/material.dart';

import 'color_schemes.dart';

ThemeData get m3LightTheme => ThemeData.light().copyWith(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      splashFactory: NoSplash.splashFactory,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
      ),
    );
