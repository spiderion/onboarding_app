import 'dart:ui';

import 'package:template_package/template_package.dart';

class LocaleSubModule implements ISubModule {
  TranslationsDelegate? _translationDelegate;

  @override
  init(List<ISubModule> subModules) {}

  TranslationsDelegate translationDelegateInstance() {
    final supportedLocales = [const Locale('en'), const Locale('it')];
    _translationDelegate ??= TranslationsDelegate(supportedLocales: supportedLocales);
    return _translationDelegate!;
  }
}
