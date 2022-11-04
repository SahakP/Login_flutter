import 'package:flutter/material.dart';

class UnderText extends StatefulWidget {
  const UnderText({required this.text, super.key});
  final String text;
  @override
  State<UnderText> createState() => _UnderTextState();
}

class _UnderTextState extends State<UnderText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child: Center(
            child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 101, 109, 120),
            fontSize: 13,
            fontStyle: FontStyle.normal,
          ),
        )));
  }
}
