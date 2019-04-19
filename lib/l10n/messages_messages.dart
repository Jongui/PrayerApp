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

  static m0(churchName) => "You were invited to church ${churchName}. Confirm?";

  static m1(churchName) => "New picture added to church ${churchName}";

  static m2(userName, churchName) => "Confirm adding user ${userName} to church ${churchName}?";

  static m3(userName) => "Confirm adding user ${userName} to this pray?";

  static m4(churchName) => "Confirm membership to church ${churchName}";

  static m5(description) => "Confirm membership to pray ${description}";

  static m6(createdAt) => "Created at ${createdAt}";

  static m7(userName) => "Created by ${userName}";

  static m8(startDate, endDate) => "Pray from ${startDate} to ${endDate}";

  static m9(descr) => "You were invited to pray ${descr}. Confirm?";

  static m10(descr) => "New picture added to pray ${descr}";

  static m11(rate) => "Rated by user: ${rate}";

  static m12(rate) => "Your rate: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add new"),
    "addYourPray" : MessageLookupByLibrary.simpleMessage("Add your pray"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "changesMade" : MessageLookupByLibrary.simpleMessage("Changes were made to the data. Leave without saving it?"),
    "churchAlbum" : MessageLookupByLibrary.simpleMessage("Church Album"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Church created!"),
    "churchDeleted" : MessageLookupByLibrary.simpleMessage("Church successfully deleted"),
    "churchInvitationMessage" : m0,
    "churchMembershipInvitation" : MessageLookupByLibrary.simpleMessage("Church membership invitation"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Church name"),
    "churchNewPicture" : m1,
    "churchNotDeleted" : MessageLookupByLibrary.simpleMessage("It is no possible to delete this church"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Church updated!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Churches"),
    "city" : MessageLookupByLibrary.simpleMessage("City"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmAddingUserToChurch" : m2,
    "confirmAddingUserToPray" : m3,
    "confirmChurchMembership" : m4,
    "confirmPrayMembership" : m5,
    "continueWithoutSave" : MessageLookupByLibrary.simpleMessage("Continue without saving?"),
    "country" : MessageLookupByLibrary.simpleMessage("Country"),
    "createdAt" : m6,
    "createdBy" : m7,
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deletingChurch" : MessageLookupByLibrary.simpleMessage("Deleting church"),
    "deletingPicture" : MessageLookupByLibrary.simpleMessage("Deleting Picture"),
    "description" : MessageLookupByLibrary.simpleMessage("Description"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Edit User"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Edit your pray"),
    "endDate" : MessageLookupByLibrary.simpleMessage("End Date"),
    "enterSomeText" : MessageLookupByLibrary.simpleMessage("Please enter some text"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Error while saving!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hello"),
    "imageUploaded" : MessageLookupByLibrary.simpleMessage("Image uploaded"),
    "mandatoryField" : MessageLookupByLibrary.simpleMessage("Inform a value"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noPicturesFound" : MessageLookupByLibrary.simpleMessage("No pictures found"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Not informed"),
    "only45Characters" : MessageLookupByLibrary.simpleMessage("Max. 45 characters"),
    "pictureTaken" : MessageLookupByLibrary.simpleMessage("Picture taken!"),
    "pictureUploaded" : MessageLookupByLibrary.simpleMessage("Picture uploaded"),
    "possibleActions" : MessageLookupByLibrary.simpleMessage("Possible Actions"),
    "prayAlbum" : MessageLookupByLibrary.simpleMessage("Pray Album"),
    "prayCreated" : MessageLookupByLibrary.simpleMessage("Pray created!"),
    "prayEdited" : MessageLookupByLibrary.simpleMessage("Pray edited"),
    "prayFromTo" : m8,
    "prayInvitationMessage" : m9,
    "prayMembershipInvitation" : MessageLookupByLibrary.simpleMessage("Pray membership invitation"),
    "prayNewPicture" : m10,
    "prays" : MessageLookupByLibrary.simpleMessage("Prays"),
    "ratedByUser" : m11,
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
    "yes" : MessageLookupByLibrary.simpleMessage("Yes"),
    "yourRate" : m12
  };
}
