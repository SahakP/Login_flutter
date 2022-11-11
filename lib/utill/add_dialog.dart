import 'package:flutter/material.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({required this.title, required this.content, super.key});
  final String title;
  final String content;
  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'YES',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'NO',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );

    //   // ignore: always_declare_return_types
    //   showAlertDialog(BuildContext context) {
    //     // Create button
    //     final Widget okButton = TextButton(
    //       child: const Text('OK'),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     );

    //     // Create AlertDialog
    //     final alert = AlertDialog(
    //       title: const Text('User Not Found'),
    //       content: const Text('Try enter correct data'),
    //       actions: [
    //         okButton,
    //       ],
    //     );

    //     // show the dialog
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return alert;
    //       },
    //     );
    //   }
    // }
  }
}
