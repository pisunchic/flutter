import 'package:flutter/material.dart';
import 'appointments/appointments.dart';
import 'contacts/contacts.dart';
import 'notes/notes.dart';
import 'tasks/tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal In1formation Manager',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 170, 232, 195),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Personal Information Manager'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calendar_today), text: 'Appointments'),
                Tab(icon: Icon(Icons.contacts), text: 'Contacts'),
                Tab(icon: Icon(Icons.note), text: 'Notes'),
                Tab(icon: Icon(Icons.check_box), text: 'Tasks'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Appointments(),
              Contacts(),
              Notes(),
              Tasks(),
            ],
          ),
        ),
      ),
    );
  }
}
