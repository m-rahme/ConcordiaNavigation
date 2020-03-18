import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';
import 'package:flutter/material.dart';

//Localization for French/English Support
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

  String get profile => Intl.message(
        'Profile',
        name: 'profile',
        desc: 'Profile for the user',
        locale: localeName,
      );

  String get schedule => Intl.message(
        'Schedule',
        name: 'schedule',
        desc: 'Schedule',
        locale: localeName,
      );

  String get interest => Intl.message(
        'Outdoor Interest',
        name: 'interest',
        desc: 'Outdoor Interest',
        locale: localeName,
      );

  String get settings => Intl.message(
        'Settings',
        name: 'settings',
        desc: 'Settings',
        locale: localeName,
      );

  String get shuttle => Intl.message(
        'Shuttle Schedule',
        name: 'shuttle',
        desc: 'Shuttle Scedule',
        locale: localeName,
      );

  String get checkShuttleSchedule => Intl.message(
        "Check Shuttle Schedule for More Info",
        name: 'checkShuttleSchedule',
        desc: 'Check Shuttle Schedule',
        locale: localeName,
      );

  String get comingSoon => Intl.message(
        "Coming Soon!",
        name: 'comingSoon',
        desc: 'Coming Soon!',
        locale: localeName,
      );

  String get currentLocation => Intl.message(
        "Current Location",
        name: 'currentLocation',
        desc: 'Current Location',
        locale: localeName,
      );

  String get chooseStartingPoint => Intl.message(
        "Choose Starting Point",
        name: 'chooseStartingPoint',
        desc: 'Choose Starting Point',
        locale: localeName,
      );

  String get chooseDestination => Intl.message(
        "Choose Destination",
        name: 'chooseDestination',
        desc: 'Choose Destination',
        locale: localeName,
      );

  String get errorOccurred => Intl.message(
        "Error Occurred",
        name: 'errorOccurred',
        desc: 'Error Occurred',
        locale: localeName,
      );

  String get concordiaShuttleBus => Intl.message(
        "Concordia Shuttle Bus",
        name: 'concordiaShuttleBus',
        desc: 'Concordia Shuttle Bus',
        locale: localeName,
      );
  String get sgwCampus => Intl.message(
        "SGW Campus, Montreal",
        name: 'sgwCampus',
        desc: 'SGW Campus, Montreal',
        locale: localeName,
      );
  String get loyolaCampus => Intl.message(
        "Loyola Campus, Montreal",
        name: 'loyolaCampus',
        desc: 'Loyola Campus, Montreal',
        locale: localeName,
      );
  String get quebecCanada => Intl.message(
        "Quebec, Canada",
        name: 'quebecCanada',
        desc: 'Quebec, Canada',
        locale: localeName,
      );
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
