// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  get localeName => 'en';

  static m0(userName, churchName) => "Confirm adding user ${userName} to church ${churchName}?";

  static m1(createdAt) => "Created at ${createdAt}";

  static m2(userName) => "Created by ${userName}";

  static m3(startDate, endDate) => "Pray from ${startDate} to ${endDate}";

  static m4(rate) => "Rated by user: ${rate}";

  static m5(rate) => "Your rate: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add new"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Church created!"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Church name"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Church updated!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Churches"),
    "city" : MessageLookupByLibrary.simpleMessage("City"),
    "confirmAddingUserToChurch" : m0,
    "createdAt" : m1,
    "createdBy" : m2,
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Edit User"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Edit your pray"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Error while saving!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hello"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Not informed"),
    "prayFromTo" : m3,
    "ratedByUser" : m4,
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "title" : MessageLookupByLibrary.simpleMessage("Praying App"),
    "userUpdated" : MessageLookupByLibrary.simpleMessage("Usuário atualizado!"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("View church"),
    "yourRate" : m5
  };
}
