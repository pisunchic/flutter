import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'notesModel.dart';
import 'notesList.dart';
import 'notesEntry.dart';

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<NotesModel>(
      model: notesModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Notes'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list), text: 'List'),
                Tab(icon: Icon(Icons.edit), text: 'Entry'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NotesList(),
              NotesEntry(),
            ],
          ),
        ),
      ),
    );
  }
}
