import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'tasksModel.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TasksModel>(
      builder: (BuildContext context, Widget? child, TasksModel model) {
        return ListView.builder(
          itemCount: model.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            var task = model.tasks[index];
            return Dismissible(
              key: Key(task.id.toString()),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                model.deleteTask(task.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task deleted')),
                );
              },
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.isCompleted ? 'Completed' : 'Pending'),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    model.toggleTaskCompletion(task.id, value ?? false);
                  },
                ),
                onTap: () {
                  model.setCurrentTask(task);
                  model.setStackIndex(1);
                },
              ),
            );
          },
        );
      },
    );
  }
}
