import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contactsModel.dart';

class ContactsEntry extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (BuildContext context, Widget? child, ContactsModel model) {
        if (model.currentContact != null) {
          _nameController.text = model.currentContact!.name;
          _phoneController.text = model.currentContact!.phone;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Contact Entry'),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.saveContact(
                      _nameController.text,
                      _phoneController.text,
                    );
                    model.setStackIndex(0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Contact saved')),
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
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d\+]')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      if (!RegExp(r'^[\+0-9]+$').hasMatch(value)) {
                        return 'Phone number can only contain digits and "+"';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
