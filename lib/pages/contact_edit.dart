import 'package:flutter/material.dart';

import '../widgets/contact_edit_field.dart';

class ContactEdit extends StatelessWidget {
  const ContactEdit({
    super.key,
    required this.contactCurrentData,
    required this.nameController,
    required this.phoneController,
    required this.onSubmit,
  });

  // getting the currentData of the contact,
  // and then filling the controllers with that data, such that
  // the it can be updated easily
  // this is different from the add user page, where the fields are empty
  final Map contactCurrentData;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              ContactEditField(
                initialText: contactCurrentData['name'],
                controller: nameController,
                placeholder: 'Name',
                icon: const Icon(Icons.person),
              ),
              ContactEditField(
                initialText: contactCurrentData['phone'],
                controller: phoneController,
                placeholder: 'Phone',
                icon: const Icon(Icons.phone),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
