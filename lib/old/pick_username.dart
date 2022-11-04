// import 'package:flutter/material.dart';
// import 'package:snap_chat_copy/password.dart';
// import 'package:snap_chat_copy/widgets/back_button.dart';
// import 'package:snap_chat_copy/widgets/button_submit.dart';
// import 'package:snap_chat_copy/widgets/header.dart';
// import 'package:snap_chat_copy/widgets/un_focused.dart';
// import 'package:snap_chat_copy/widgets/under_text.dart';

// import '../model/user_model.dart';

// class PickUsername extends StatefulWidget {
//   const PickUsername({required this.users, super.key});
//   final User users;
//   @override
//   State<PickUsername> createState() => _PickUsernameState();
// }

// class _PickUsernameState extends State<PickUsername> {
//   TextEditingController controllerUsername = TextEditingController();
//   //User users = User();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: UnFocusedWidget(
//             child: Stack(children: [
//           const BackBtn(blueWhite: true),
//           Column(
//             children: [
//               const Header(header: 'Pick a username'),
//               _renderUnderHeaderText(),
//               _renderUsernameTF(),
//               _renderUsernameErrorMsg(),
//               _submitButton(),
//             ],
//           ),
//         ])));
//   }

//   Widget _renderUnderHeaderText() {
//     return const UnderText(
//       text: 'Your username is how friends add you \n on Snapchat',
//     );
//   }

//   Widget _renderUsernameErrorMsg() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 40,
//             vertical: 2,
//           ),
//           child: Text(
//             !_usernameValidation
//                 ? 'must be greather then or equals 5 symbols'
//                 : '',
//             style: const TextStyle(
//                 color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//           ))
//     ]);
//   }

//   Widget _renderUsernameTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 40,
//         vertical: 2,
//       ),
//       child: TextField(
//         autofocus: true,
//         controller: controllerUsername,
//         onChanged: (value) {
//           widget.users.userName = controllerUsername.text;
//           setState(() {});
//         },
//         style: const TextStyle(
//             color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
//         decoration: const InputDecoration(
//             labelText: 'USERNAME', prefixStyle: TextStyle(color: Colors.blue)),
//       ),
//     );
//   }

//   Widget _submitButton() {
//     return Expanded(
//         child: Align(
//       alignment: FractionalOffset.bottomCenter,
//       child: ButtonSubmit(
//         isActive: _usernameValidation,
//         title: 'Continue',
//         onTap: () {
//           _usernameValidation
//               ? Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Password(users: widget.users)))
//               : null;
//         },
//       ),
//     ));
//   }

//   bool get _usernameValidation {
//     if (controllerUsername.text.length > 4) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
