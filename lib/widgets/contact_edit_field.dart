import 'package:flutter/material.dart';

class ContactEditField extends StatelessWidget {
  const ContactEditField({
    super.key,
    required this.initialText,
    required this.controller,
    required this.placeholder,
    required this.icon,
  });

  // setting the initialText with the user's current data
  final String initialText;
  final TextEditingController controller;
  final String placeholder;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    controller.text = initialText;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          contentPadding: const EdgeInsets.all(8.0),
          prefixIcon: icon,
        ),
      ),
    );
  }
}
