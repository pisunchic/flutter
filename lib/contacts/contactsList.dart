import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contactsModel.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (BuildContext context, Widget? child, ContactsModel model) {
        return ListView.builder(
          itemCount: model.contacts.length,
          itemBuilder: (BuildContext context, int index) {
            var contact = model.contacts[index];
            return Dismissible(
              key: Key(contact.id.toString()),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                model.deleteContact(contact.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contact deleted')),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 3.0),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 62, 54, 54)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  onTap: () {
                    model.setCurrentContact(contact);
                    model.setStackIndex(1);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
