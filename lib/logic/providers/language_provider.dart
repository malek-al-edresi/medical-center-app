import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _appLocale = const Locale('ar');

  Locale get appLocale => _appLocale;

  void changeLanguage(Locale type) {
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar")) {
      _appLocale = const Locale("ar");
    } else {
      _appLocale = const Locale("en");
    }
    notifyListeners();
  }
}
