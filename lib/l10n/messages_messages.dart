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

  static m0(userName) => "Created by ${userName}";

  static m1(startDate, endDate) => "Pray from ${startDate} to ${endDate}";

  static m2(rate) => "Rated by user: ${rate}";

  static m3(rate) => "Your rate: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Add new"),
    "addYourPray" : MessageLookupByLibrary.simpleMessage("Add your pray"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Church created!"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Church name"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Church updated!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Churches"),
    "city" : MessageLookupByLibrary.simpleMessage("City"),
    "createdBy" : m0,
    "description" : MessageLookupByLibrary.simpleMessage("Description"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Edit User"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Edit your pray"),
    "endDate" : MessageLookupByLibrary.simpleMessage("End Date"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Error while saving!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hello"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Not informed"),
    "prayCreated" : MessageLookupByLibrary.simpleMessage("Pray created!"),
    "prayFromTo" : m1,
    "ratedByUser" : m2,
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "startDate" : MessageLookupByLibrary.simpleMessage("Start Date"),
    "title" : MessageLookupByLibrary.simpleMessage("Praying App"),
    "userUpdated" : MessageLookupByLibrary.simpleMessage("User updated!"),
    "yourRate" : m3
  };
}
