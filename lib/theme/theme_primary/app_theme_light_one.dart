import 'package:flutter/material.dart';

import '../base_theme.dart';

ThemeData appThemeLight = baseTheme.copyWith(
  brightness: _colorScheme.brightness,
  unselectedWidgetColor: _colorScheme.onSurface.withOpacity(0.55),
  textTheme: baseTheme.textTheme,
  scaffoldBackgroundColor: _colorScheme.background,
  colorScheme: _colorScheme,
  cardColor: _colorScheme.surface,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: _colorScheme.surface),
  tabBarTheme: TabBarTheme(labelColor: _colorScheme.background),
  appBarTheme:
      baseTheme.appBarTheme.copyWith(backgroundColor: _colorScheme.background),
  elevatedButtonTheme: baseTheme.elevatedButtonTheme,
  cardTheme:
      CardTheme(color: _colorScheme.surface, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
);


ColorScheme _colorScheme = baseColorScheme.copyWith(
    surface: Colors.white,
    onSurface: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    brightness: Brightness.light);
