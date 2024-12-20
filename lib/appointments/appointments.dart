import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'appointmentsModel.dart';
import 'appointmentsList.dart';
import 'appointmentsEntry.dart';

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppointmentsModel>(
      model: appointmentsModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Appointments'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list), text: 'List'),
                Tab(icon: Icon(Icons.edit), text: 'Entry'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AppointmentsList(),
              AppointmentsEntry(),
            ],
          ),
        ),
      ),
    );
  }
}
