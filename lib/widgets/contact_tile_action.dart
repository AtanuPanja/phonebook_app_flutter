import 'package:flutter/material.dart';

class ContactTileAction extends StatelessWidget {
  const ContactTileAction({
    super.key,
    required this.buttonType,
    required this.action,
  });

  final String buttonType;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      ),
      child: InkWell(
        onTap: action,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              buttonType.toLowerCase() == 'edit' ? Icons.edit : Icons.delete,
              size: 16,
            ),
            Text(buttonType),
          ],
        ),
      ),
    );
  }
}
