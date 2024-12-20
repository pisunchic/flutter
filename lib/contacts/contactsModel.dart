import 'package:scoped_model/scoped_model.dart';

class Contact {
  int id;
  String name;
  String phone;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
  });
}

class ContactsModel extends Model {
  List<Contact> _contacts = [];
  Contact? _currentContact;
  int _stackIndex = 0;

  List<Contact> get contacts => List.unmodifiable(_contacts);
  Contact? get currentContact => _currentContact;
  int get stackIndex => _stackIndex;

  void loadContacts(List<Contact> contacts) {
    _contacts = contacts;
    notifyListeners();
  }

  void setCurrentContact(Contact contact) {
    _currentContact = contact;
    notifyListeners();
  }

  void setStackIndex(int index) {
    _stackIndex = index;
    notifyListeners();
  }

  void saveContact(String name, String phone) {
    // if (_currentContact == null) {
    _currentContact = Contact(
      id: _contacts.isNotEmpty ? _contacts.last.id + 1 : 1,
      name: name,
      phone: phone,
    );
    _contacts.add(_currentContact!);
    // } else {
    //   _currentContact!.name = name;
    //   _currentContact!.phone = phone;
    // }
    notifyListeners();
  }

  void deleteContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }
}

final ContactsModel contactsModel = ContactsModel();
