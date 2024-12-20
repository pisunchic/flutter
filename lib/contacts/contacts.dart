import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contactsModel.dart';
import 'contactsList.dart';
import 'contactsEntry.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactsModel>(
      model: contactsModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Contacts'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list), text: 'List'),
                Tab(icon: Icon(Icons.edit), text: 'Entry'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ContactsList(),
              ContactsEntry(),
            ],
          ),
        ),
      ),
    );
  }
}
