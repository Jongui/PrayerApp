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

  static m0(churchName) => "Sie wurde für Gemeinde ${churchName} eingeladen. Bestätigen?";

  static m1(churchName) => "Neues Bild auf Gemeindealbum ${churchName} eingefügt";

  static m2(userName, churchName) => "Bestätigen das Benutzer ${userName} zu ${churchName} gehört?";

  static m3(userName) => "Bestätigen Benutzer ${userName} zu diesem Gebet?";

  static m4(churchName) => "Bestätigen Angehörigkeit zur Gemeinde ${churchName}";

  static m5(description) => "Bestätigen Teilnahme in Gebet ${description}";

  static m6(createdAt) => "Erzeugt am ${createdAt}";

  static m7(userName) => "Erzeugt von ${userName}";

  static m8(startDate, endDate) => "Gebet von ${startDate} bis ${endDate}";

  static m9(descr) => "Sie wurden für Gebetsgruppe ${descr}. Bestätigen?";

  static m10(descr) => "Neues Bild auf Gebet ${descr}";

  static m11(rate) => "Benutzerbewertung: ${rate}";

  static m12(rate) => "Deine Bewertung: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add neu"),
    "addYourPray" : MessageLookupByLibrary.simpleMessage("Lege Ihren gebet an"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "changesMade" : MessageLookupByLibrary.simpleMessage("Daten wurden geändert. Weiter ohne speichern?"),
    "churchAlbum" : MessageLookupByLibrary.simpleMessage("Gemeindealbum"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Gemeinde erzeugt!"),
    "churchDeleted" : MessageLookupByLibrary.simpleMessage("Gemeinde gelöscht"),
    "churchInvitationMessage" : m0,
    "churchMembershipInvitation" : MessageLookupByLibrary.simpleMessage("Gemeindeglied Einladung"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Gemeindename"),
    "churchNewPicture" : m1,
    "churchNotDeleted" : MessageLookupByLibrary.simpleMessage("Diese Gemeinde kann nicht gelöscht werden"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Gemeinde aktualisiert!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Gemeinden"),
    "city" : MessageLookupByLibrary.simpleMessage("Stadt"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "confirmAddingUserToChurch" : m2,
    "confirmAddingUserToPray" : m3,
    "confirmChurchMembership" : m4,
    "confirmPrayMembership" : m5,
    "continueWithoutSave" : MessageLookupByLibrary.simpleMessage("Weiter ohne speichern?"),
    "country" : MessageLookupByLibrary.simpleMessage("Land"),
    "createdAt" : m6,
    "createdBy" : m7,
    "delete" : MessageLookupByLibrary.simpleMessage("Löschen"),
    "deletingChurch" : MessageLookupByLibrary.simpleMessage("Gemeinde löschen"),
    "deletingPicture" : MessageLookupByLibrary.simpleMessage("Bild wird gelöscht"),
    "description" : MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "edit" : MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Benutzer bearbeiten"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Bearbeite Ihren Gebet"),
    "endDate" : MessageLookupByLibrary.simpleMessage("Datum bis"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Error while saving!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hallo"),
    "imageUploaded" : MessageLookupByLibrary.simpleMessage("Bild hochgeladen"),
    "mandatoryField" : MessageLookupByLibrary.simpleMessage("Wert eingeben"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "no" : MessageLookupByLibrary.simpleMessage("Nein"),
    "noPicturesFound" : MessageLookupByLibrary.simpleMessage("Keine Bilder gefunden"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Nicht informierd"),
    "pictureTaken" : MessageLookupByLibrary.simpleMessage("Bild gemacht!"),
    "pictureUploaded" : MessageLookupByLibrary.simpleMessage("Bild hochgeladen"),
    "possibleActions" : MessageLookupByLibrary.simpleMessage("Aktionen"),
    "prayAlbum" : MessageLookupByLibrary.simpleMessage("Gebetsalbum"),
    "prayCreated" : MessageLookupByLibrary.simpleMessage("Gebet angelegt!"),
    "prayEdited" : MessageLookupByLibrary.simpleMessage("Gebet verändert"),
    "prayFromTo" : m8,
    "prayInvitationMessage" : m9,
    "prayMembershipInvitation" : MessageLookupByLibrary.simpleMessage("Gebetseinladung"),
    "prayNewPicture" : m10,
    "prays" : MessageLookupByLibrary.simpleMessage("Gebete"),
    "ratedByUser" : m11,
    "rotatingImage" : MessageLookupByLibrary.simpleMessage("Bild wird gedreht..."),
    "save" : MessageLookupByLibrary.simpleMessage("Speichern"),
    "savingChurch" : MessageLookupByLibrary.simpleMessage("Gemeinde wird gespeichert..."),
    "savingPray" : MessageLookupByLibrary.simpleMessage("Gebet speichern"),
    "savingUser" : MessageLookupByLibrary.simpleMessage("Benutzer speichern"),
    "searchUser" : MessageLookupByLibrary.simpleMessage("Benutzer suchen"),
    "startDate" : MessageLookupByLibrary.simpleMessage("Datum von"),
    "takeAPicture" : MessageLookupByLibrary.simpleMessage("Machen Sie ein Foto"),
    "takingPicture" : MessageLookupByLibrary.simpleMessage("Bild verarbeiten"),
    "tapACamera" : MessageLookupByLibrary.simpleMessage("Kamera wählen"),
    "title" : MessageLookupByLibrary.simpleMessage("Gebets App"),
    "uploadingPicture" : MessageLookupByLibrary.simpleMessage("Bild hochladen"),
    "userUpdated" : MessageLookupByLibrary.simpleMessage("Benutzer aktualisiert!"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("Gemeinde ansehen"),
    "viewPray" : MessageLookupByLibrary.simpleMessage("Gebet ansehen"),
    "yes" : MessageLookupByLibrary.simpleMessage("Ja"),
    "yourRate" : m12
  };
}
