import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'appointmentsModel.dart';

class AppointmentsEntry extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppointmentsModel>(
      builder: (BuildContext context, Widget? child, AppointmentsModel model) {
        if (model.currentAppointment != null) {
          _titleController.text = model.currentAppointment!.title;
          _descriptionController.text = model.currentAppointment!.description;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Appointment Entry'),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.saveAppointment(
                      _titleController.text,
                      _descriptionController.text,
                    );
                    model.setStackIndex(0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Appointment saved')),
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
                  leading: Icon(Icons.description),
                  title: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Date and Time'),
                  subtitle: Text(
                    model.currentAppointment?.dateTime.toString() ??
                        'Select date and time',
                  ),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        DateTime dateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                        model.setDateTime(dateTime);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
