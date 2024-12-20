import 'package:scoped_model/scoped_model.dart';

class Task {
  int id;
  String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}

class TasksModel extends Model {
  List<Task> _tasks = [];
  Task? _currentTask;
  int _stackIndex = 0;

  List<Task> get tasks => List.unmodifiable(_tasks);
  Task? get currentTask => _currentTask;
  int get stackIndex => _stackIndex;

  void loadTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void setCurrentTask(Task task) {
    _currentTask = task;
    notifyListeners();
  }

  void setStackIndex(int index) {
    _stackIndex = index;
    notifyListeners();
  }

  void saveTask(String title) {
    _currentTask = Task(
      id: _tasks.isNotEmpty ? _tasks.last.id + 1 : 1,
      title: title,
    );
    _tasks.add(_currentTask!);
    notifyListeners();
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskCompletion(int id, bool isCompleted) {
    try {
      Task task = _tasks.firstWhere((task) => task.id == id);
      task.isCompleted = isCompleted;
      notifyListeners();
    } catch (e) {
      // Task not found, no action needed
    }
  }

  void setTaskCompletion(bool isCompleted) {
    if (_currentTask != null) {
      _currentTask!.isCompleted = isCompleted;
      notifyListeners();
    }
  }
}

final TasksModel tasksModel = TasksModel();
