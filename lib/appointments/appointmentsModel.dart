import 'package:scoped_model/scoped_model.dart';

class Appointment {
  int id;
  String title;
  String description;
  DateTime dateTime;

  Appointment({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

class AppointmentsModel extends Model {
  // Список всех записей
  List<Appointment> _appointments = [];

  // Текущая выбранная запись
  Appointment? _currentAppointment;

  // Индекс текущего экрана
  int _stackIndex = 0;

  List<Appointment> get appointments => List.unmodifiable(_appointments);
  Appointment? get currentAppointment => _currentAppointment;
  int get stackIndex => _stackIndex;

  /// Загружает записи в модель
  void loadAppointments(List<Appointment> appointments) {
    _appointments = appointments;
    notifyListeners();
  }

  /// Устанавливает текущую запись
  void setCurrentAppointment(Appointment appointment) {
    _currentAppointment = appointment;
    notifyListeners();
  }

  /// Устанавливает текущий индекс экрана
  void setStackIndex(int index) {
    _stackIndex = index;
    notifyListeners();
  }

  /// Сохраняет новую запись или обновляет существующую
  void saveAppointment(String title, String description) {
    // if (_currentAppointment == null) {
    _currentAppointment = Appointment(
      id: _appointments.isNotEmpty ? _appointments.last.id + 1 : 1,
      title: title,
      description: description,
      dateTime: DateTime.now(),
    );
    _appointments.add(_currentAppointment!);
    // } else {
    //   _currentAppointment!.title = title;
    //   _currentAppointment!.description = description;
    // }
    notifyListeners();
  }

  /// Удаляет запись
  void deleteAppointment(int id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }

  /// Устанавливает дату и время для текущей записи
  void setDateTime(DateTime dateTime) {
    if (_currentAppointment != null) {
      _currentAppointment!.dateTime = dateTime;
      notifyListeners();
    }
  }

  /// Получает уникальные дни с записями
  List<DateTime> getUniqueDays() {
    return _appointments
        .map((appointment) => appointment.dateTime.dateOnly)
        .toSet()
        .toList()
      ..sort();
  }

  /// Получает записи для определенного дня
  List<Appointment> getAppointmentsForDay(DateTime day) {
    return _appointments
        .where((appointment) => appointment.dateTime.dateOnly == day.dateOnly)
        .toList();
  }
}

extension DateOnlyCompare on DateTime {
  /// Преобразует `DateTime` в объект без времени (только дата)
  DateTime get dateOnly => DateTime(year, month, day);
}

// Экземпляр модели для использования в приложении
final AppointmentsModel appointmentsModel = AppointmentsModel();
