import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

import '../classes/contact.dart';
import '../classes/number.dart';

class ContactsProvider extends ChangeNotifier{
  List<Contact> myContacts=[];
  List<Contact> searchResults=[];
  CountryCode? countryCode=CountryCode.fromDialCode("20");

  updateCountryCode(CountryCode? newCountryCode){
    if (newCountryCode!=null){
      countryCode=newCountryCode;
      notifyListeners();
    }
  }

  addContact(Contact newContact){
    if (newContact.name.isEmpty){
      return;
    }
    if (newContact.numbers!.isEmpty){
      return;
    }
    if (newContact.numbers!.first.number.isEmpty){
      return;
    }
    myContacts.add(newContact);
    searchResults=myContacts;

    notifyListeners();
  }

  editContact(int id , String name){
    Contact findContact=myContacts.where((element)=>element.contactId==id).toList().first;
    int findContactIndex=myContacts.indexOf(findContact);
    if (name!=findContact.name && name.isNotEmpty){
      myContacts[findContactIndex].name=name;
      searchResults=myContacts;

      notifyListeners();
    }
  }

  addNumber(int id,Number newNumber){
    Contact findContact=myContacts.where((element)=>element.contactId==id).toList().first;
    int findContactIndex=myContacts.indexOf(findContact);
    myContacts[findContactIndex].numbers!.add(
      newNumber
    );
    searchResults=myContacts;
    notifyListeners();
  }

  void removeContact(int contactId) {
    myContacts.removeWhere((element) => element.contactId==contactId);
    searchResults=myContacts;

    notifyListeners();
  }

  void search(String value) {
    if (value.isEmpty){
      searchResults=myContacts;
      notifyListeners();
      return;
    }
    searchResults=myContacts.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    notifyListeners();
  }

  Contact getContact(int id){
    return myContacts.where((element) => element.contactId==id).toList().first;
  }

}