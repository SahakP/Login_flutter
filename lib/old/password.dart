// import 'package:flutter/material.dart';
// import 'package:snap_chat_copy/model/user_model.dart';
// import 'package:snap_chat_copy/model/user_storage.dart';
// import 'package:snap_chat_copy/widgets/back_button.dart';
// import 'package:snap_chat_copy/widgets/button_submit.dart';
// import 'package:snap_chat_copy/widgets/header.dart';
// import 'package:snap_chat_copy/widgets/home.dart';
// import 'package:snap_chat_copy/widgets/un_focused.dart';
// import 'package:snap_chat_copy/widgets/under_text.dart';

// class Password extends StatefulWidget {
//   const Password({required this.users, super.key});
//   final User users;

//   @override
//   State<Password> createState() => _PasswordState();
// }

// class _PasswordState extends State<Password> {
//   TextEditingController controllerPassword = TextEditingController();
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
//               const Header(header: 'Set a password'),
//               _renderUnderHeaderText(),
//               _renderPasswordTF(),
//               _renderUsernameErrorMsg(),
//               _submitButton(),
//             ],
//           ),
//         ])));
//   }

//   Widget _renderUnderHeaderText() {
//     return const UnderText(
//         text: 'Your password should be at least 8 \n characters');
//   }

//   Widget _renderUsernameErrorMsg() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 40,
//             vertical: 2,
//           ),
//           child: Text(
//             !_passwordValidation
//                 ? 'must be greather then or equals 8 symbols'
//                 : '',
//             style: const TextStyle(
//                 color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//           ))
//     ]);
//   }

//   Widget _renderPasswordTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 40,
//         vertical: 2,
//       ),
//       child: TextField(
//         autofocus: true,
//         controller: controllerPassword,
//         onChanged: (value) {
//           widget.users.password = controllerPassword.text;

//           setState(() {
//             StorageUser.users.add(widget.users);
//           });
//         },
//         style: const TextStyle(
//             color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
//         decoration: const InputDecoration(
//             labelText: 'PASSWORD',
//             labelStyle: TextStyle(
//               color: Color.fromARGB(255, 154, 160, 167),
//             ),
//             prefixStyle: TextStyle(color: Colors.blue)),
//       ),
//     );
//   }

//   Widget _submitButton() {
//     return Expanded(
//         child: Align(
//       alignment: FractionalOffset.bottomCenter,
//       child: ButtonSubmit(
//         isActive: _passwordValidation,
//         title: 'Continue',
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const HomePage()));
//         },
//       ),
//     ));
//   }

//   bool get _passwordValidation {
//     if (controllerPassword.text.length > 7) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
