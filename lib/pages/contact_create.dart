import 'package:flutter/material.dart';

import '../widgets/contact_create_field.dart';

class ContactCreate extends StatelessWidget {
  const ContactCreate({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.onSubmit,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              ContactCreateField(
                controller: nameController,
                placeholder: 'Name',
                icon: const Icon(Icons.person),
              ),
              ContactCreateField(
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
