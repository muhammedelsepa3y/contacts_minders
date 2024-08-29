import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/contacts_provider.dart';

class EditContactScreen extends StatelessWidget {
  int id;
  EditContactScreen(this.id);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: Provider.of<ContactsProvider>(context, listen: false)
        .getContact(id).name);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Container(
        child: Column(
          children: [

            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ContactsProvider>(context, listen: false)
                        .editContact(id, nameController.text);
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back"),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
