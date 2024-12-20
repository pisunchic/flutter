import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'tasksModel.dart';
import 'tasksList.dart';
import 'tasksEntry.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TasksModel>(
      model: tasksModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tasks'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list), text: 'List'),
                Tab(icon: Icon(Icons.edit), text: 'Entry'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TasksList(),
              TasksEntry(),
            ],
          ),
        ),
      ),
    );
  }
}

