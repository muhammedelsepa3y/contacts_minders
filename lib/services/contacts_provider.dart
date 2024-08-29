import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

import '../classes/contact.dart';
import '../classes/number.dart';

class ContactsProvider extends ChangeNotifier{
  List<Contact> myContacts=[];
  CountryCode? countryCode=CountryCode.fromDialCode("20");

  updateCountryCode(CountryCode? newCountryCode){
    if (newCountryCode!=null){
      countryCode=newCountryCode;
      notifyListeners();
    }
  }

  addContact(Contact newContact){
    myContacts.add(newContact);
    notifyListeners();
  }

  editContact(int id , String name){
    Contact findContact=myContacts.where((element)=>element.contactId==id).toList().first;
    int findContactIndex=myContacts.indexOf(findContact);
    if (name!=findContact.name && name.isNotEmpty){
      myContacts[findContactIndex].name=name;
    }
  }

  addNumber(int id,Number newNumber){
    Contact findContact=myContacts.where((element)=>element.contactId==id).toList().first;
    int findContactIndex=myContacts.indexOf(findContact);
    myContacts[findContactIndex].numbers!.add(
      newNumber
    );
  }

}