import 'package:flutter/material.dart';

/// Immutable state representing the current application locale.
class LanguageState {
  final Locale locale;

  const LanguageState({required this.locale});

  /// Creates a copy of this state with the given locale.
  LanguageState copyWith({Locale? locale}) {
    return LanguageState(locale: locale ?? this.locale);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageState && other.locale == locale;
  }

  @override
  int get hashCode => locale.hashCode;
}
