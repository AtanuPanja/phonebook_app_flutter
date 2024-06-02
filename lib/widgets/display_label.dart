import 'package:flutter/material.dart';

class DisplayLabel extends StatelessWidget {
  const DisplayLabel({
    super.key,
    required this.heading,
    required this.content,
  });

  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(
            color: Colors.white,
          ),
          children: <TextSpan>[
            TextSpan(
              text: heading,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const TextSpan(
              text: "   ",
            ),
            TextSpan(
              text: content,
            ),
          ]),
    );
  }
}
