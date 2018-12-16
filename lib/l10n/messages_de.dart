// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'de';

  static m0(userName, churchName) => "Bestätigen das Benutzer ${userName} zu ${churchName} gehört?";

  static m1(createdAt) => "Erzeugt am ${createdAt}";

  static m2(userName) => "Erzeugt von ${userName}";

  static m3(startDate, endDate) => "Betten von ${startDate} bis ${endDate}";

  static m4(rate) => "Benutzerbewertung: ${rate}";

  static m5(rate) => "Deine Bewertung: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add neu"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Gemeinde erzeugt!"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Gemeindename"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Gemeinde aktualisiert!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Gemeinden"),
    "city" : MessageLookupByLibrary.simpleMessage("Stadt"),
    "confirmAddingUserToChurch" : m0,
    "createdAt" : m1,
    "createdBy" : m2,
    "edit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Benutzer bearbeiten"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Bearbeite dein Betten"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Fehler beim Speichern!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hallo"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Nicht informierd"),
    "prayFromTo" : m3,
    "ratedByUser" : m4,
    "save" : MessageLookupByLibrary.simpleMessage("Speichern"),
    "title" : MessageLookupByLibrary.simpleMessage("Betten App"),
    "userUpdated" : MessageLookupByLibrary.simpleMessage("Benutzer aktualisiert!"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("Gemeinde sehen"),
    "yourRate" : m5
  };
}
