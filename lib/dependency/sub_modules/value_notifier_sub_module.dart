import 'package:dependency_provider/base_sub_module.dart';
import 'package:flutter_app_template/core/notifiers/theme_notifier/theme_notifier.dart';
import 'package:flutter_app_template/theme/theme_primary/app_theme_dark.dart';
import 'package:flutter_app_template/theme/theme_primary/app_theme_light_one.dart';

class ValueNotifierSubModule implements ISubModule {
  late ThemeNotifier themeNotifier;

  @override
  init(List<ISubModule> subModules) {
    themeNotifier = ThemeNotifier(appThemeLight);
  }
}
