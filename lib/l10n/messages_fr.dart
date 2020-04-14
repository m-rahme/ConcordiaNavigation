// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// Messages in French
final messages = new MessageLookup();
// Alias that returns a default message if a message is absent
typedef String MessageIfAbsent(String messageStr, List<dynamic> args);
// Gets the messages to display
class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "schedule": MessageLookupByLibrary.simpleMessage("Horaire"),
        "interest": MessageLookupByLibrary.simpleMessage("Intérêt Extérieur"),
        "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "shuttle": MessageLookupByLibrary.simpleMessage("Horaire de la Navette")
      };
}
