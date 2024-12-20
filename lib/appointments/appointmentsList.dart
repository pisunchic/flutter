import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'appointmentsModel.dart';

class AppointmentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppointmentsModel>(
      builder: (BuildContext context, Widget? child, AppointmentsModel model) {
        List<DateTime> uniqueDays = model.getUniqueDays();

        return DefaultTabController(
          length: uniqueDays.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Appointments by Day"),
              bottom: TabBar(
                isScrollable: true,
                tabs: uniqueDays.map((day) {
                  return Tab(
                    text: "${day.year}-${day.month}-${day.day}",
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: uniqueDays.map((day) {
                return _buildAppointmentsForDay(day, model);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppointmentsForDay(DateTime day, AppointmentsModel model) {
    List<Appointment> appointmentsForDay = model.getAppointmentsForDay(day);

    return ListView.builder(
      itemCount: appointmentsForDay.length,
      itemBuilder: (BuildContext context, int index) {
        var appointment = appointmentsForDay[index];
        return Dismissible(
          key: Key(appointment.id.toString()),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            model.deleteAppointment(appointment.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Appointment deleted')),
            );
          },
          child: ListTile(
            title: Text(appointment.title),
            subtitle: Text(appointment.description),
            onTap: () {
              model.setCurrentAppointment(appointment);
              model.setStackIndex(1);
            },
          ),
        );
      },
    );
  }
}
