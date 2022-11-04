import 'package:flutter/material.dart';

class ButtonSubmit extends StatefulWidget {
  const ButtonSubmit(
      {required this.isActive,
      required this.title,
      required this.onTap,
      super.key});
  final String title;
  final bool isActive;
  final Function() onTap;

  @override
  State<ButtonSubmit> createState() => _ButtonSubmitState();
}

class _ButtonSubmitState extends State<ButtonSubmit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 40,
        width: 250,
        decoration: BoxDecoration(
            color: widget.isActive
                ? const Color.fromARGB(255, 36, 174, 252)
                : const Color.fromARGB(255, 185, 193, 199),
            borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: SizedBox(
            height: 40,
            width: 250,
            child: TextButton(
              onPressed: widget.onTap,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
