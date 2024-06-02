import 'package:flutter/material.dart';

import '../widgets/display_label.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({
    super.key,
    required this.name,
    required this.phone,
  });

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: screenWidth / 1.5,
          height: screenHeight / 2.5,
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                ),
              ]),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade700,
                foregroundColor: Colors.white,
                radius: 50,
                child: const Icon(
                  Icons.person_outlined,
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayLabel(
                    heading: 'Name: ',
                    content: name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DisplayLabel(
                    heading: 'Phone number: ',
                    content: phone,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
