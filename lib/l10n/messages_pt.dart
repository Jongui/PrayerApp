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

  static m1(userName) => "Confirmar usuário ${userName} para essa oração?";

  static m2(churchName) => "Confirmar membresia na igreja ${churchName}";

  static m3(description) => "Confirmar participação na oração ${description}";

  static m4(createdAt) => "Criado em ${createdAt}";

  static m5(userName) => "Criado por ${userName}";

  static m6(startDate, endDate) => "Orar de ${startDate} até ${endDate}";

  static m7(rate) => "Avaliação: ${rate}";

  static m8(rate) => "Sua avaliação: ${rate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Adicionar"),
    "addNew" : MessageLookupByLibrary.simpleMessage("Novo"),
    "addYourPray" : MessageLookupByLibrary.simpleMessage("Crie sua oração"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancelar"),
    "churchCreated" : MessageLookupByLibrary.simpleMessage("Igreja criada!"),
    "churchName" : MessageLookupByLibrary.simpleMessage("Nome da igreja"),
    "churchUpdated" : MessageLookupByLibrary.simpleMessage("Igreja atualizada!"),
    "churches" : MessageLookupByLibrary.simpleMessage("Igrejas"),
    "city" : MessageLookupByLibrary.simpleMessage("Cidade"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirmAddingUserToChurch" : m0,
    "confirmAddingUserToPray" : m1,
    "confirmChurchMembership" : m2,
    "confirmPrayMembership" : m3,
    "country" : MessageLookupByLibrary.simpleMessage("País"),
    "createdAt" : m4,
    "createdBy" : m5,
    "delete" : MessageLookupByLibrary.simpleMessage("Excluir"),
    "deletingPicture" : MessageLookupByLibrary.simpleMessage("Excluindo imagem"),
    "description" : MessageLookupByLibrary.simpleMessage("Descrição"),
    "edit" : MessageLookupByLibrary.simpleMessage("Editar"),
    "editUser" : MessageLookupByLibrary.simpleMessage("Editar Usuário"),
    "editYourPray" : MessageLookupByLibrary.simpleMessage("Edite sua oração"),
    "endDate" : MessageLookupByLibrary.simpleMessage("Data Final"),
    "errorWhileSaving" : MessageLookupByLibrary.simpleMessage("Erro ao salvar!"),
    "hello" : MessageLookupByLibrary.simpleMessage("Olá"),
    "mandatoryField" : MessageLookupByLibrary.simpleMessage("Informar valor"),
    "name" : MessageLookupByLibrary.simpleMessage("Nome"),
    "noPicturesFound" : MessageLookupByLibrary.simpleMessage("Nenhuma foto encontrada"),
    "notInformed" : MessageLookupByLibrary.simpleMessage("Não informado"),
    "pictureTaken" : MessageLookupByLibrary.simpleMessage("Foto tirada!"),
    "pictureUploaded" : MessageLookupByLibrary.simpleMessage("Imagem salva"),
    "possibleActions" : MessageLookupByLibrary.simpleMessage("Ações possíveis"),
    "prayCreated" : MessageLookupByLibrary.simpleMessage("Oração criada!"),
    "prayEdited" : MessageLookupByLibrary.simpleMessage("Oração editada"),
    "prayFromTo" : m6,
    "prays" : MessageLookupByLibrary.simpleMessage("Orações"),
    "ratedByUser" : m7,
    "rotatingImage" : MessageLookupByLibrary.simpleMessage("Girando imagem..."),
    "save" : MessageLookupByLibrary.simpleMessage("Salvar"),
    "savingChurch" : MessageLookupByLibrary.simpleMessage("Salvando igreja..."),
    "savingPray" : MessageLookupByLibrary.simpleMessage("Salvando oração"),
    "savingUser" : MessageLookupByLibrary.simpleMessage("Salvando usuário"),
    "searchUser" : MessageLookupByLibrary.simpleMessage("Buscar usuários"),
    "startDate" : MessageLookupByLibrary.simpleMessage("Data Início"),
    "takeAPicture" : MessageLookupByLibrary.simpleMessage("Tire uma foto"),
    "takingPicture" : MessageLookupByLibrary.simpleMessage("Processando imagem"),
    "tapACamera" : MessageLookupByLibrary.simpleMessage("Escolha uma câmera"),
    "title" : MessageLookupByLibrary.simpleMessage("Aplicativo de Orações"),
    "uploadingPicture" : MessageLookupByLibrary.simpleMessage("Salvando imagem"),
    "viewChurch" : MessageLookupByLibrary.simpleMessage("Visualizar Igreja"),
    "yourRate" : m8
  };
}
