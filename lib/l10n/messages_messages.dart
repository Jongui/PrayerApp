// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  get localeName => 'messages';

  static m0(userName, churchName) => "Confirm adding user ${userName} to church ${churchName}?";

  static m1(userName) => "Confirm adding user ${userName} to this pray?";

  static m2(churchName) => "Confirm membership to church ${churchName}";

  static m3(description) => "Confirm membership to pray ${description}";

  static m4(createdAt) => "Created at ${createdAt}";

  static m5(userName) => "Created by ${userName}";

  static m6(startDate, endDate) => "Pray from ${startDate} to ${endDate}";

  static m7(rate) => "Rated by user: ${rate}";

  static m8(rate) => "Your rate: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add new"),
    "addYourPray" : MessageLookupByLibrary.simpleMessage("Add your pray"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Church created!"),
    "churchDeleted" : MessageLookupByLibrary.simpleMessage("Church successfully deleted"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Church name"),
    "churchNotDeleted" : MessageLookupByLibrary.simpleMessage("It is no possible to delete this church"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Church updated!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Churches"),
    "city" : MessageLookupByLibrary.simpleMessage("City"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmAddingUserToChurch" : m0,
    "confirmAddingUserToPray" : m1,
    "confirmChurchMembership" : m2,
    "confirmPrayMembership" : m3,
    "country" : MessageLookupByLibrary.simpleMessage("Country"),
    "createdAt" : m4,
    "createdBy" : m5,
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deletingChurch" : MessageLookupByLibrary.simpleMessage("Deleting church"),
    "deletingPicture" : MessageLookupByLibrary.simpleMessage("Deleting Picture"),
    "description" : MessageLookupByLibrary.simpleMessage("Description"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Edit User"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Edit your pray"),
    "endDate" : MessageLookupByLibrary.simpleMessage("End Date"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Error while saving!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hello"),
    "mandatoryField" : MessageLookupByLibrary.simpleMessage("Inform a value"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "noPicturesFound" : MessageLookupByLibrary.simpleMessage("No pictures found"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Not informed"),
    "pictureTaken" : MessageLookupByLibrary.simpleMessage("Picture taken!"),
    "pictureUploaded" : MessageLookupByLibrary.simpleMessage("Picture uploaded"),
    "possibleActions" : MessageLookupByLibrary.simpleMessage("Possible Actions"),
    "prayCreated" : MessageLookupByLibrary.simpleMessage("Pray created!"),
    "prayEdited" : MessageLookupByLibrary.simpleMessage("Pray edited"),
    "prayFromTo" : m6,
    "prays" : MessageLookupByLibrary.simpleMessage("Prays"),
    "ratedByUser" : m7,
    "rotatingImage" : MessageLookupByLibrary.simpleMessage("Rotating Image..."),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "savingChurch" : MessageLookupByLibrary.simpleMessage("Saving church..."),
    "savingPray" : MessageLookupByLibrary.simpleMessage("Saving Pray"),
    "savingUser" : MessageLookupByLibrary.simpleMessage("Saving user"),
    "searchUser" : MessageLookupByLibrary.simpleMessage("Search User"),
    "startDate" : MessageLookupByLibrary.simpleMessage("Start Date"),
    "takeAPicture" : MessageLookupByLibrary.simpleMessage("Take a picture"),
    "takingPicture" : MessageLookupByLibrary.simpleMessage("Taking picture"),
    "tapACamera" : MessageLookupByLibrary.simpleMessage("Tap a camera"),
    "title" : MessageLookupByLibrary.simpleMessage("Praying App"),
    "uploadingPicture" : MessageLookupByLibrary.simpleMessage("Uploading picture"),
    "userUpdated" : MessageLookupByLibrary.simpleMessage("User updated!"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("View church"),
    "viewPray" : MessageLookupByLibrary.simpleMessage("View pray"),
    "yourRate" : m8
  };
}
