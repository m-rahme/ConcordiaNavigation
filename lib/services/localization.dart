import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';
import 'package:flutter/material.dart';

/// Deals with converting strings to French when necessary
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

  String get toggle {
    return Intl.message(
      'Toggle Building Highlights',
      name: 'toggle',
      desc: 'Building Highlights',
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

  String get interest {
    return Intl.message(
      'Outdoor Interest',
      name: 'interest',
      desc: 'Outdoor Interest',
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

  String get shuttle {
    return Intl.message(
      'Shuttle Schedule',
      name: 'shuttle',
      desc: 'Shuttle Scedule',
      locale: localeName,
    );
  }

  String get indoor {
    return Intl.message(
      'Indoor',
      name: 'indoor',
      desc: 'Indoor',
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
