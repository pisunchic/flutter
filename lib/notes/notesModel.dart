import 'package:scoped_model/scoped_model.dart';

class Note {
  int id;
  String title;
  String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });
}

class NotesModel extends Model {
  List<Note> _notes = [];
  Note? _currentNote;
  int _stackIndex = 0;

  List<Note> get notes => List.unmodifiable(_notes);
  Note? get currentNote => _currentNote;
  int get stackIndex => _stackIndex;

  void loadNotes(List<Note> notes) {
    _notes = notes;
    notifyListeners();
  }

  void setCurrentNote(Note note) {
    _currentNote = note;
    notifyListeners();
  }

  void setStackIndex(int index) {
    _stackIndex = index;
    notifyListeners();
  }

  void saveNote(String title, String content) {
    // if (_currentNote == null) {
    final newNote = Note(
      id: _notes.isNotEmpty ? _notes.last.id + 1 : 1,
      title: title,
      content: content,
    );
    _notes.add(newNote);
    _currentNote = newNote;
    // } else {
    //   _currentNote!.title = title;
    //   _currentNote!.content = content;
    // }
    notifyListeners();
  }

  void deleteNote(int id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}

final NotesModel notesModel = NotesModel();
