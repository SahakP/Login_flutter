import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({required this.header, super.key});
  final String? header;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 10),
        child: Center(
            child: Text(
          widget.header!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20,
            fontStyle: FontStyle.normal,
          ),
        )));
  }
}
