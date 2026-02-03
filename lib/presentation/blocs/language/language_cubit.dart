import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

/// Cubit for managing application language/locale.
///
/// Exposes intention-revealing methods for language changes.
/// Does not contain UI logic or depend on Flutter widgets.
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(locale: Locale('ar')));

  /// Changes the application locale.
  ///
  /// If the new locale is the same as the current locale, no change occurs.
  void changeLanguage(Locale locale) {
    if (state.locale == locale) return;
    emit(LanguageState(locale: locale));
  }

  /// Toggles between Arabic and English locales.
  void toggleLanguage() {
    final newLocale = state.locale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');
    emit(LanguageState(locale: newLocale));
  }
}
