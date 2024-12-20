import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'notesModel.dart';

class NotesEntry extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NotesModel>(
      builder: (BuildContext context, Widget? child, NotesModel model) {
        if (model.currentNote != null) {
          _titleController.text = model.currentNote!.title;
          _contentController.text = model.currentNote!.content;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Note Entry'),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.saveNote(
                      _titleController.text,
                      _contentController.text,
                    );
                    _titleController.clear();
                    _contentController.clear();
                    model.setStackIndex(0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note saved')),
                    );
                  }
                },
              )
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.title),
                  title: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.description),
                  title: TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'Content'),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
