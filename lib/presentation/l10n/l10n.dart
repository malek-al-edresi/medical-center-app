
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_localizations.dart';

class L10n {
  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    DefaultWidgetsLocalizations.delegate,
    DefaultMaterialLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];
}
