import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_template/theme/theme_primary/app_theme_dark.dart';
import 'package:flutter_app_template/theme/theme_primary/app_theme_light_one.dart';

class ThemeNotifier extends ValueNotifier<ThemeData> {
  ThemeNotifier(ThemeData value) : super(value) {
    setStatusBarBrightness(value.brightness);
  }

  void switchToDark() {
    value = getDarkMode();
    setStatusBarBrightness(value.brightness);
  }

  void switchToLight() {
    value = appThemeLight;
    setStatusBarBrightness(value.brightness);
  }

  bool isDark() => value == getDarkMode();

  ThemeData getDarkMode() => appThemeDark;

  ThemeData getLightMode() => appThemeLight;

  void setStatusBarBrightness(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: brightness));
  }
}
