import 'package:flutter/material.dart';

class ContactCreateField extends StatelessWidget {
  const ContactCreateField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.icon,
  });

  final TextEditingController controller;
  final String placeholder;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
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
