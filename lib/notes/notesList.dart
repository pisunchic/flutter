import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'notesModel.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NotesModel>(
      builder: (BuildContext context, Widget? child, NotesModel model) {
        return ListView.builder(
          itemCount: model.notes.length, // Количество заметок в списке
          itemBuilder: (BuildContext context, int index) {
            var note = model.notes[index]; // Получаем текущую заметку
            return Dismissible(
              key:
                  Key(note.id.toString()), // Уникальный ключ для каждой заметки
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                model.deleteNote(note.id); // Удаляем заметку
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note deleted')),
                );
              },
              child: ListTile(
                title: Text(note.title), // Заголовок заметки
                subtitle: Text(note.content), // Содержимое заметки
                onTap: () {
                  model.setCurrentNote(note); // Устанавливаем текущую заметку
                  model.setStackIndex(1); // Переход к экрану редактирования
                },
              ),
            );
          },
        );
      },
    );
  }
}
