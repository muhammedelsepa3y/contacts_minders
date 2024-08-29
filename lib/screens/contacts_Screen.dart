import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/classes/number.dart';
import 'package:untitled4/services/contacts_provider.dart';

import '../classes/contact.dart';

class ContactsScreen extends StatelessWidget {
   ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts"),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // showModalBottomSheet(context: context, builder:
          // (context)=>Container(
          //   height: 200,
          //   color: Colors.red,
          // )
          // );
          showDialog(context: context, builder:(ctx){
            TextEditingController nameController=TextEditingController();
            TextEditingController countryCodeController=TextEditingController();
            TextEditingController numberController=TextEditingController();
            return AlertDialog(
              title:Text("Add Contact"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name"
                    ),

                  ),

                  Consumer<ContactsProvider>(
                    builder: (key,contactsProvider,_){
                      return TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: "Number",
                            prefixIcon: SizedBox(
                                width: 120,

                                child: InkWell(
                                  onTap: ()async{
                                    const countryPickerWithParams = FlCountryCodePicker(
                                      showDialCode: true,
                                      showSearchBar: true,
                                    );
                                    final picked= await countryPickerWithParams.showPicker(context: context);
                                    if (picked!=null){
                                      contactsProvider.updateCountryCode(picked);

                                    }

                                  },
                                  child: Row(
                                    children: [
                                      contactsProvider.countryCode!.flagImage(),
                                      SizedBox(width: 10,),
                                      Text(contactsProvider.countryCode!.dialCode)
                                    ],
                                  ),
                                ))
                        ),


                      );
                    },
                  ),

                ],
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(ctx);
                }, child: Text("Cancel")),
                ElevatedButton(onPressed: (){
                  Navigator.pop(ctx);
                  Number number=
                  Number(number: numberController.text,
                      countryCode: Provider.of<ContactsProvider>(context,listen: false).countryCode.toString()
                  );
                  Contact newContact=Contact(name: nameController.text,numbers: [
                    number
                  ]);
                  Provider.of<ContactsProvider>(context,listen: false).addContact(newContact);
                }, child: Text("Confirm")),

              ],

            );
          } );

        },
        child: Icon(Icons.add),
      ),
      body: Consumer<ContactsProvider>(
        builder: (_,contactsProvider,__){
          return ListView.builder(
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(contactsProvider.myContacts[index].name),
                  subtitle: Text(
                      contactsProvider.myContacts[index].numbers==null||
                          contactsProvider.myContacts[index].numbers!.isEmpty?
                          "":contactsProvider.myContacts[index].numbers!.first.number
                  ),
                );
              },
            itemCount: contactsProvider.myContacts.length,
          );
        },
      ),
    );
  }
}
