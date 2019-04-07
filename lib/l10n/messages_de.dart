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

  static m1(userName) => "Bestätigen Benutzer ${userName} zu diesem Gebet?";

  static m2(churchName) => "Bestätigen Angehörigkeit zur Gemeinde ${churchName}";

  static m3(description) => "Bestätigen Teilnahme in Gebet ${description}";

  static m4(createdAt) => "Erzeugt am ${createdAt}";

  static m5(userName) => "Erzeugt von ${userName}";

  static m6(startDate, endDate) => "Gebet von ${startDate} bis ${endDate}";

  static m7(rate) => "Benutzerbewertung: ${rate}";

  static m8(rate) => "Deine Bewertung: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add neu"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Gemeinde erzeugt!"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Gemeindename"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Gemeinde aktualisiert!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Gemeinden"),
    "city" : MessageLookupByLibrary.simpleMessage("Stadt"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "confirmAddingUserToChurch" : m0,
    "confirmAddingUserToPray" : m1,
    "confirmChurchMembership" : m2,
    "confirmPrayMembership" : m3,
    "country" : MessageLookupByLibrary.simpleMessage("Land"),
    "createdAt" : m4,
    "createdBy" : m5,
    "delete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "deletingPicture" : MessageLookupByLibrary.simpleMessage("Bild wird gelöscht"),
    "edit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Benutzer bearbeiten"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Bearbeiten dein Gebet"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Fehler beim Speichern!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hallo"),
    "mandatoryField" : MessageLookupByLibrary.simpleMessage("Wert eingeben"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "noPicturesFound" : MessageLookupByLibrary.simpleMessage("Keine Bilder gefunden"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Nicht informierd"),
    "pictureTaken" : MessageLookupByLibrary.simpleMessage("Bild gemacht!"),
    "pictureUploaded" : MessageLookupByLibrary.simpleMessage("Bild hochgeladen"),
    "possibleActions" : MessageLookupByLibrary.simpleMessage("Aktionen"),
    "prayEdited" : MessageLookupByLibrary.simpleMessage("Gebet verändert"),
    "prayFromTo" : m6,
    "prays" : MessageLookupByLibrary.simpleMessage("Gebete"),
    "ratedByUser" : m7,
    "rotatingImage" : MessageLookupByLibrary.simpleMessage("Bild wird gedreht..."),
    "save" : MessageLookupByLibrary.simpleMessage("Speichern"),
    "savingChurch" : MessageLookupByLibrary.simpleMessage("Gemeinde wird gespeichert..."),
    "savingPray" : MessageLookupByLibrary.simpleMessage("Gebet speichern"),
    "savingUser" : MessageLookupByLibrary.simpleMessage("Benutzer speichern"),
    "searchUser" : MessageLookupByLibrary.simpleMessage("Benutzer suchen"),
    "takeAPicture" : MessageLookupByLibrary.simpleMessage("Machen Sie ein Foto"),
    "takingPicture" : MessageLookupByLibrary.simpleMessage("Bild verarbeiten"),
    "tapACamera" : MessageLookupByLibrary.simpleMessage("Kamera wählen"),
    "title" : MessageLookupByLibrary.simpleMessage("Gebets App"),
    "uploadingPicture" : MessageLookupByLibrary.simpleMessage("Bild hochladen"),
    "userUpdated" : MessageLookupByLibrary.simpleMessage("Benutzer aktualisiert!"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("Gemeinde sehen"),
    "yourRate" : m8
  };
}
