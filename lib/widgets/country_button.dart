import 'package:flutter/material.dart';

class CountryButton extends StatefulWidget {
  const CountryButton({required this.onTap, super.key});

  final Function() onTap;

  @override
  State<CountryButton> createState() => _CountryButtonState();
}

class _CountryButtonState extends State<CountryButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 0,
          left: 30,
        ),
        child: Container(
          height: 150,
          width: 90,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 150,
            width: 90,
            child: TextButton(
              onPressed: widget.onTap,
              child: const Text(''),
            ),
          ),
        ),
      ),
    );
  }
}
