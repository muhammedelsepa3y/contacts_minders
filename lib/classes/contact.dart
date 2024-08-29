import 'number.dart';

class Contact{
  String name;
  static int id=0;
  int contactId=0;
  List<Number>? numbers=[];

  Contact({required this.name,this.numbers}){
   id++;
   contactId=id;
  }
}

