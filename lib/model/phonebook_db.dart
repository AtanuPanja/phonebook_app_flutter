import 'package:hive_flutter/hive_flutter.dart';

class PhonebookDB {
  List contactList = [];

  // reference the contact box
  final contactBox = Hive.box('contactBox');

  // if the app is being used for the first time ever
  void generateInitialData() {
    contactList = [
      {
        'name': 'Name1',
        'phone': '6666666666',
      },
      {
        'name': 'Name2',
        'phone': '7777777777',
      },
      {
        'name': 'Name3',
        'phone': '8888888888',
      },
    ];
  }

  /*
    the loadContactData was an async method, so, when the app was opened after restart of the phone, the data was not visible. Only when a new data
    was being added, using the add button, then all the data was displayed.
    On removing the async await, from loadContactData method, this issue got resolved
   */
  void loadContactData() {
    contactList = contactBox.get('contactData');
  }

  void updateDatabase() {
    contactBox.put('contactData', contactList);
  }
}
