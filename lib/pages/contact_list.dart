import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/phonebook_db.dart';
import '../validations/validations.dart';
import '../widgets/contact_tile.dart';
import 'contact_create.dart';
import 'contact_edit.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  // Referencing the hive box
  final contactBox = Hive.box('contactBox');

  PhonebookDB phonebookDB = PhonebookDB();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if the app has been opened for the first time ever
    if (contactBox.get('contactData') == null) {
      phonebookDB.generateInitialData();
    }
    // else if there is some data in the database
    else {
      phonebookDB.loadContactData();
    }
  }

  // controllers for the text fields
  // they are defined as a part of the state of the root widget
  // and then passed into the child widgets when needed
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // adding contact - changing the data
  void addContactToList() {
    String name = nameController.value.text;
    String phone = phoneController.value.text;
    if (validateName(name) && validatePhone(phone)) {
      var newUser = {'name': name, 'phone': phone};

      setState(() {
        // adding the contact to the hive database
        phonebookDB.contactList.add(newUser);
        phonebookDB.updateDatabase();

        Navigator.of(context).pop();
        // clearing the controllers everytime a new contact is created
        // this would ensure that the next time, add contact page must have empty fields
        nameController.clear();
        phoneController.clear();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              Text("Added contact successfully"),
            ],
          ),
          showCloseIcon: true,
        ));
      });
    } else {
      // showing an alert on the screen, for validation of the fields
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade100,
            content: SizedBox(
              width: 200,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name or phone is invalid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  // adding contact - passed as callback to the button
  // this callback, passes the controllers, and the addContactToList action, to the ContactCreate page
  // there onSubmit action triggers the addContactToList action here.
  void addContact() {
    nameController.clear();
    phoneController.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactCreate(
          nameController: nameController,
          phoneController: phoneController,
          onSubmit: addContactToList,
        ),
      ),
    );
  }

  // deleting contact - performing update on the data
  // deleting the data from the hive database, and then updating the database
  void deleteContactFromList(int index) {
    setState(() {
      phonebookDB.contactList.removeAt(index);
      phonebookDB.updateDatabase();

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            Text("Deleted contact successfully"),
          ],
        ),
        showCloseIcon: true,
      ));
    });
  }

  // deleting contact - passed as callback to the button
  // this callback shows a dialog box, to ask for confirmation before deleting
  // an index of the user is passed into the deleteContactFromList method, to ensure only that entry gets deleted
  void deleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.purple.shade200,
        content: SizedBox(
          width: 200,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Are you sure you want to delete this contact?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Confirm'),
                    onPressed: () => deleteContactFromList(index),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.purple.shade100),
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // editing contact - edit the contact data in the list
  // edit/update the contact data in the database
  // edits the contact at the index passed from the calling method
  void editContactInList(int index) {
    String name = nameController.value.text;
    String phone = phoneController.value.text;

    if (validateName(name) && validatePhone(phone)) {
      var updatedContact = {
        'name': name,
        'phone': phone,
      };

      setState(() {
        phonebookDB.contactList[index] = updatedContact;
        phonebookDB.updateDatabase();
      });
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            Text("Updated contact successfully"),
          ],
        ),
        showCloseIcon: true,
      ));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade100,
            content: SizedBox(
              width: 200,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name or phone is invalid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  // editing contact - passed as callback to the button
  // this callback passes the current data, the controllers for the text-fields,
  // and the editContactInList action method with the value of the index to edit
  void editContact(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactEdit(
                contactCurrentData: phonebookDB.contactList[index],
                nameController: nameController,
                phoneController: phoneController,
                onSubmit: () => editContactInList(index))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Contacts'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addContact,
          child: const Icon(Icons.person_add_alt_1),
        ),
        body: phonebookDB.contactList.isNotEmpty
            ? ListView.builder(
                itemCount: phonebookDB.contactList.length,
                itemBuilder: (context, index) {
                  return ContactTile(
                    name: phonebookDB.contactList[index]['name'],
                    phone: phonebookDB.contactList[index]['phone'],
                    editUser: () => editContact(index),
                    deleteUser: () => deleteContact(index),
                  );
                },
              )
            : const Center(
                child: Text("No contacts available"),
              ));
  }
}
