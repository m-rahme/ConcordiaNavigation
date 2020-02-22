import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';
import 'package:flutter/material.dart';

class ConcordiaLocalizations {
  ConcordiaLocalizations(this.localeName);

  static Future<ConcordiaLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return ConcordiaLocalizations(localeName);
    });
  }

  static ConcordiaLocalizations of(BuildContext context) {
    return Localizations.of<ConcordiaLocalizations>(
        context, ConcordiaLocalizations);
  }

  final String localeName;

  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'Profile for the user',
      locale: localeName,
    );
  }

  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: 'Schedule',
      locale: localeName,
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings',
      locale: localeName,
    );
  }
}

class ConcordiaLocalizationsDelegate
    extends LocalizationsDelegate<ConcordiaLocalizations> {
  const ConcordiaLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<ConcordiaLocalizations> load(Locale locale) =>
      ConcordiaLocalizations.load(locale);

  @override
  bool shouldReload(ConcordiaLocalizationsDelegate old) => false;
}
