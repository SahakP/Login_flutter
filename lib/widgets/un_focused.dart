import 'package:flutter/material.dart';

class UnFocusedWidget extends StatefulWidget {
  const UnFocusedWidget({required this.child, super.key});

  final Widget child;

  @override
  State<UnFocusedWidget> createState() => _UnFocusedWidgetState();
}

class _UnFocusedWidgetState extends State<UnFocusedWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: widget.child,
        onTap: () {
          final currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        });
  }
}
