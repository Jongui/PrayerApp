// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  get localeName => 'pt';

  static m0(userName, churchName) => "Confirmar usuario ${userName} para igreja ${churchName}?";

  static m1(createdAt) => "Criado em ${createdAt}";

  static m2(userName) => "Criado por ${userName}";

  static m3(startDate, endDate) => "Orar de ${startDate} até ${endDate}";

  static m4(rate) => "Avaliação: ${rate}";

  static m5(rate) => "Sua avaliação: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Adicionar"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Novo"),
    "addYourPray" : MessageLookupByLibrary.simpleMessage("Crie sua oração"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Igreja criada!"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Nome da igreja"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Igreja atualizada!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Igrejas"),
    "city" : MessageLookupByLibrary.simpleMessage("Cidade"),
    "confirmAddingUserToChurch" : m0,
    "createdAt" : m1,
    "createdBy" : m2,
    "description" : MessageLookupByLibrary.simpleMessage("Descrição"),
    "edit" : MessageLookupByLibrary.simpleMessage("Editar"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Editar Usuário"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Edite sua oração"),
    "endDate" : MessageLookupByLibrary.simpleMessage("Data Final"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Erro ao salvar!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Olá"),
    "name" : MessageLookupByLibrary.simpleMessage("Nome"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Não informado"),
    "prayCreated" : MessageLookupByLibrary.simpleMessage("Oração criada!"),
    "prayFromTo" : m3,
    "ratedByUser" : m4,
    "save" : MessageLookupByLibrary.simpleMessage("Salvar"),
    "startDate" : MessageLookupByLibrary.simpleMessage("Data Início"),
    "title" : MessageLookupByLibrary.simpleMessage("Aplicativo de Orações"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("Visualizar Igreja"),
    "yourRate" : m5
  };
}
