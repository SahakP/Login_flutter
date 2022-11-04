// ignore: file_names
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final controllerFirstName = TextEditingController();
//   final controllerLastName = TextEditingController();
//   User users = User();

//   @override
//   void initState() {
//     super.initState();

//     // Start listening to changes.
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     controllerFirstName.dispose();
//     controllerLastName.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body:
//             //SingleChildScrollView(child:
//             UnFocusedWidget(
//           child: Stack(
//             children: [
//               const BackBtn(blueWhite: true), //SingleChildScrollView
//               Column(
//                 children: [
//                   const Header(header: "What's youre name"),
//                   _renderFirstNameTF(),
//                   _renderFirstNameErrorMsg(),
//                   _renderLastNameTF(),
//                   _renderLastNameErrorMsg(),
//                   _renderLinks(),
//                   _signUpButton(),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }

//   Widget _renderFirstNameErrorMsg() {
//     if (!_firstNameValidation) {
//       return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         const Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 60,
//               vertical: 0,
//             ),
//             child: Text(
//               'must be greater than or equal 1 symbol',
//               style: TextStyle(
//                   color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//             ))
//       ]);
//     } else {
//       return const Text('');
//     }
//   }

//   Widget _renderFirstNameTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 60,
//         vertical: 0,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 0),
//         child: TextField(
//           autofocus: true,
//           controller: controllerFirstName,
//           onChanged: (value) {
//             _firstNameValidation;
//             //_renderFirstNameErrorMsg();
//             us ers.firstName = controllerFirstName.text;

//             setState(() {
//               // textFirstName = value.toString();
//             });
//           },
//           style: const TextStyle(
//               color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
//           decoration: const InputDecoration(
//             labelText: 'FIRST NAME',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _renderLastNameErrorMsg() {
//     if (!_lastNameValidation) {
//       return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         const Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 60,
//               vertical: 0,
//             ),
//             child: Text(
//               'must be greater than or equal 1 symbol',
//               style: TextStyle(
//                   color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//             ))
//       ]);
//     } else {
//       return const Text('');
//     }
//   }

//   Widget _renderLastNameTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 60,
//         vertical: 0,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 0),
//         child: TextField(
//           controller: controllerLastName,
//           onChanged: (value) {
//             _lastNameValidation;
//             users.lastName = controllerLastName.text;
//             setState(() {
//               //textLastName = value.toString();
//             });
//           },
//           style: const TextStyle(
//               color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
//           decoration: const InputDecoration(
//             labelText: 'LAST NAME',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _renderLinks() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 62),
//       child: RichText(
//         text: const TextSpan(
//           style: TextStyle(color: Colors.black, fontSize: 13),
//           children: <TextSpan>[
//             TextSpan(
//                 text:
//                     'By tapping Sign Up & Accept, you acknowledge  that you have read the ',
//                 style: TextStyle(color: Colors.black)),
//             TextSpan(
//                 text: 'Privacy Policy ', style: TextStyle(color: Colors.blue)),
//             TextSpan(
//                 text: 'and agree  to the ',
//                 style: TextStyle(color: Colors.black)),
//             TextSpan(
//                 text: 'Terms of Service.',
//                 style: TextStyle(color: Colors.blue)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _signUpButton() {
//     return Expanded(
//         child: Align(
//       alignment: FractionalOffset.bottomCenter,
//       child: ButtonSubmit(
//         isActive: _isActive,
//         title: 'Sign Up & Accept',
//         onTap: () {
//           _isActive
//               ? Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Birthday(users: users)))
//               : null;
//         },
//       ),
//     ));
//   }

//   bool get _firstNameValidation {
//     return controllerFirstName.text.isNotEmpty;
//   }

//   bool get _lastNameValidation {
//     return controllerLastName.text.isNotEmpty;
//   }

//   bool get _isActive {
//     if (_firstNameValidation && _lastNameValidation) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }