import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'tasksModel.dart';

class TasksEntry extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TasksModel>(
      builder: (BuildContext context, Widget? child, TasksModel model) {
        if (model.currentTask != null) {
          _titleController.text = model.currentTask!.title;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Task Entry'),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.saveTask(_titleController.text);
                    model.setStackIndex(0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task saved')),
                    );
                  }
                },
              ),
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
                  leading: Icon(Icons.check_box),
                  title: Row(
                    children: [
                      Text('Completed'),
                      Checkbox(
                        value: model.currentTask?.isCompleted ?? false,
                        onChanged: (bool? value) {
                          model.setTaskCompletion(value ?? false);
                        },
                      ),
                    ],
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
