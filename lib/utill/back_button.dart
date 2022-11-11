import 'package:flutter/material.dart';

class BackBtn extends StatefulWidget {
  const BackBtn({required this.blueWhite, super.key});
  final bool blueWhite;
  @override
  State<BackBtn> createState() => _BackBtnState();
}

class _BackBtnState extends State<BackBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new,
            color: widget.blueWhite ? Colors.blue : Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
