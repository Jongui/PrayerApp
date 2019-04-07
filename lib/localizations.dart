import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message('Praying App',
        name: 'title', desc: 'The application title');
  }

  String get edit {
    return Intl.message('Edit',
        name: 'edit', desc: 'Edit');
  }

  String get add {
    return Intl.message('Add', name: 'add');
  }

  String get addNew{
    return Intl.message('Add new', name: 'addNew');
  }

  String get save{
    return Intl.message('Save', name: 'save');
  }

  String get hello {
    return Intl.message('Hello', name: 'hello');
  }

  String get name {
    return Intl.message('Name', name: 'name' );
  }

  String get churchName {
    return Intl.message('Church name', name: 'churchName');
  }

  String get city {
    return Intl.message('City', name: 'city');
  }

  String get notInformed {
    return Intl.message('Not informed', name: 'notInformed');
  }

  String get churchCreated {
    return Intl.message('Church created!', name: 'churchCreated');
  }

  String get errorWhileSaving {
    return Intl.message('Error while saving!', name: 'errorWhileSaving');
  }

  String get startDate {
    return Intl.message('Start Date', name: 'startDate');
  }

  String get endDate {
    return Intl.message('End Date', name: 'endDate');
  }

  String get addYourPray {
    return Intl.message('Add your pray', name: 'addYourPray');
  }

  String get description{
    return Intl.message('Description', name: 'description');
  }

  String get prayCreated{
    return Intl.message('Pray created!', name: 'prayCreated');
  }

  String get churches{
    return Intl.message('Churches', name: 'churches');
  }

  String get churchUpdated{
    return Intl.message('Church updated!', name: 'churchUpdated');
  }

  String get editYourPray{
    return Intl.message('Edit your pray', name: 'editYourPray');
  }

  String get editUser{
    return Intl.message('Edit User', name: 'editUser');
  }

  String get userUpdated{
    return Intl.message('User updated!', name: 'userUpdated');
  }

  prayFromTo(startDate, endDate) => Intl.message('Pray from $startDate to $endDate',
      name: 'prayFromTo', args: [startDate, endDate]);

  yourRate(rate) => Intl.message('Your rate: $rate', name: 'yourRate', args: [rate]);

  createdBy(userName) => Intl.message('Created by $userName', name: 'createdBy', args: [userName]);

  ratedByUser(rate) => Intl.message('Rated by user: $rate', name: 'ratedByUser', args: [rate]);

  createdAt(createdAt) => Intl.message('Created at $createdAt',
      name: 'createdAt', args: [createdAt]);

  String get viewChurch{
    return Intl.message('View church', name: 'viewChurch');
  }

  confirmAddingUserToChurch(userName, churchName) => Intl.message('Confirm adding user $userName to church $churchName?',
      name: 'confirmAddingUserToChurch', args: [userName, churchName]);

  confirmAddingUserToPray(userName) => Intl.message('Confirm adding user $userName to this pray?',
      name: 'confirmAddingUserToPray', args: [userName]);

  String get takeAPicture{
    return Intl.message('Take a picture', name: 'takeAPicture');
  }

  String get tapACamera{
    return Intl.message('Tap a camera', name: 'tapACamera');
  }

  String get pictureTaken{
    return Intl.message('Picture taken!', name: 'pictureTaken');
  }

  String get savingUser{
    return Intl.message('Saving user', name: 'savingUser');
  }

  String get takingPicture{
    return Intl.message('Taking picture', name: 'takingPicture');
  }

  String get prayEdited{
    return Intl.message('Pray edited', name: 'prayEdited');
  }

  String get mandatoryField{
    return Intl.message('Inform a value', name: 'mandatoryField');
  }

  String get savingPray{
    return Intl.message('Saving Pray', name: 'savingPray');
  }

  String get rotatingImage{
    return Intl.message('Rotating Image...', name: 'rotatingImage');
  }

  String get searchUser{
    return Intl.message('Search User', name: 'searchUser');
  }

  String get prays{
    return Intl.message('Prays', name: 'prays');
  }

  String get uploadingPicture{
    return Intl.message('Uploading picture', name: 'uploadingPicture');
  }

  String get noPicturesFound{
    return Intl.message('No pictures found', name: 'noPicturesFound');
  }

  String get pictureUploaded{
    return Intl.message('Picture uploaded', name: 'pictureUploaded');
  }

  String get savingChurch{
    return Intl.message('Saving church...', name: 'savingChurch');
  }

  String get possibleActions{
    return Intl.message('Possible Actions', name: 'possibleActions');
  }

  String get delete{
    return Intl.message('Delete', name: 'delete');
  }

  String get deletingPicture{
    return Intl.message('Deleting Picture', name: 'deletingPicture');
  }

  confirmChurchMembership(String churchName) =>
    Intl.message('Confirm membership to church $churchName', name: 'confirmChurchMembership',
      args: [churchName]);

  String get confirm{
    return Intl.message('Confirm', name: 'confirm');
  }

  String get cancel{
    return Intl.message('Cancel', name: 'cancel');
  }

  confirmPrayMembership(String description) =>
      Intl.message('Confirm membership to pray $description', name: 'confirmPrayMembership',
          args: [description]);

  String get country{
    return Intl.message('Country', name: 'country');
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}