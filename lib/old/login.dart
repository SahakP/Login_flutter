// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:snap_chat_copy/first_page.dart';
// import 'package:snap_chat_copy/login/bloc/login_bloc.dart';
// import 'package:snap_chat_copy/model/user_storage.dart';
// import 'package:snap_chat_copy/widgets/back_button.dart';
// import 'package:snap_chat_copy/widgets/button_submit.dart';
// import 'package:snap_chat_copy/widgets/header.dart';
// import 'package:snap_chat_copy/widgets/un_focused.dart';

// import '../model/user_model.dart';

// //import 'package:snap_chat_copy/widgets/under_text.dart';

// class Login extends StatefulWidget {
//   const Login(
//       {
//       //required this.findingUser,
//       super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final controllerUsername = TextEditingController();
//   final controllerPassword = TextEditingController();
//   User? findingUser;

//   @override
//   void initState() {
//     super.initState();

//     // Start listening to changes.
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     controllerUsername.dispose();
//     controllerPassword.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: UnFocusedWidget(
//           child: Stack(
//             children: [
//               const BackBtn(blueWhite: true), //SingleChildScrollView
//               Column(
//                 children: [
//                   const Header(header: 'Log in'),
//                   _renderUserNameTF(),
//                   _renderNameErrorMsg(),
//                   _renderPasswordTF(),
//                   _renderPasswordErrorMsg(),
//                   _renderLink(),
//                   _rederLogInButton(),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

// // @override
// //   Widget build(BuildContext context) {
// //       return Scaffold(
// //         resizeToAvoidBottomInset: true,
// //         backgroundColor: Colors.white,
// //         body: UnFocusedWidget(
// //           child: Stack(
// //             children: [
// //               const BackBtn(blueWhite: true),
// //               Column(
// //                 children: [
// //                   const Header(header: 'Log in'),
// //                   _renderUserNameTF(),
// //                   _renderNameErrorMsg(),
// //                   _renderPasswordTF(),
// //                   _renderPasswordErrorMsg(),
// //                   _renderLink(),
// //                   _rederLogInButton(),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ));
// //   }
// //   }

//   // bool _isNameValid = false,
//   //     _isPasswordValid = false,
//   //     // _usernameAndPassIsValid = true,
//   //     _visibility = true;

//   //final loginBloc = LoginBloc();

//   // @override
//   // Widget build(BuildContext context) {
//   //   return BlocProvider<LoginBloc>(
//   //       create: (context) => loginBloc,
//   //       child: BlocConsumer<LoginBloc, LoginState>(
//   //         listener: _listener,

//   //         builder: _builder,

//   //         // listener: (context, state) {
//   //         //   if (state is NameValid) {
//   //         //     _isNameValid = state.isUserNameValid;
//   //         //   }
//   //         //   if (state is PassValid) {
//   //         //     _isPasswordValid = state.IsPasswordValid;
//   //         //   }
//   //         // },
//   //       ));
//   // }

//   // void _listener(contaxt, state) {
//   //   if (state is NameValidState) {
//   //     _isNameValid = true;
//   //   }

//   //   if (state is NameInvalidState) {
//   //     _isNameValid = false;
//   //   }

//   //   if (state is PasswordInvalidState) {
//   //     _isPasswordValid = state.IsPasswordValid;
//   //   }
//   //   if (state is PassObscureState) {
//   //     _visibility = state.passwordIsObscured;
//   //   }
//   //   if (state is ValidationState) {
//   //     // _usernameAndPassIsValid = state.entryAllow;
//   //     findingUser = state.user;
//   //   }
//   // }

//   // Widget _render() {
//   //   return Scaffold(
//   //       resizeToAvoidBottomInset: true,
//   //       backgroundColor: Colors.white,
//   //       body: UnFocusedWidget(
//   //         child: Stack(
//   //           children: [
//   //             const BackBtn(blueWhite: true),
//   //             Column(
//   //               children: [
//   //                 const Header(header: 'Log in'),
//   //                 _renderUserNameTF(),
//   //                 _renderNameErrorMsg(),
//   //                 _renderPasswordTF(),
//   //                 _renderPasswordErrorMsg(),
//   //                 _renderLink(),
//   //                 _rederLogInButton(),
//   //               ],
//   //             ),
//   //           ],
//   //         ),
//   //       ));
//   // }

//   Widget _rederLogInButton() {
//     return Expanded(
//         child: Align(
//       alignment: FractionalOffset.bottomCenter,
//       child: ButtonSubmit(
//         isActive: _isActive,
//         title: 'log in',
//         onTap: () {
//           // loginBloc.add(NameTFEvent(userName: controllerUsername.text));
//           // loginBloc.add(PasswordTFEvent(password: controllerPassword.text));
//           // loginBloc.add(LogInButtonEvent(
//           //     email: controllerUsername.text,
//           //     password: controllerPassword.text));
//           //loginBloc.add(ShopEnumsLoadEvent(index: 1));

//           final us = findingUser;
//           if (us != null) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => FirstPage(
//                           user: us,
//                         )));
//           }
//         },
//       ),
//     ));
//   }

//   Widget _renderUserNameTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 40,
//         vertical: 0,
//       ),
//       child: TextField(
//         autofocus: true,
//         controller: controllerUsername,
//         onChanged: (value) {
//           setState(() {});
//         },
//         style: const TextStyle(
//             color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
//         decoration: const InputDecoration(
//             labelText: 'USERNAME OR EMAIL',
//             contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
//       ),
//     );
//   }

//   Widget _renderNameErrorMsg() {
//     if (!_nameValidation) {
//       return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         const Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 40,
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

//   Widget _renderPasswordTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 40,
//         vertical: 0,
//       ),
//       child: TextField(
//         controller: controllerPassword,
//         onChanged: (value) {
//           setState(() {});
//           //loginBloc.add(PasswordTFEvent(password: controllerPassword.text));
//         },
//         obscuringCharacter: '*',
//         obscureText: true,
//         style: const TextStyle(
//             color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12),
//         decoration: const InputDecoration(
//             labelText: 'PASSWORD',
//             suffixIcon: Icon(Icons.visibility_off_sharp),
//             contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
//       ),
//     );
//   }

//   Widget _renderPasswordErrorMsg() {
//     if (!_passwordValidation) {
//       return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         const Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 40,
//               vertical: 0,
//             ),
//             child: Text(
//               'must be greater than or equal 8 symbol',
//               style: TextStyle(
//                   color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//             ))
//       ]);
//     } else {
//       return const Text('');
//     }
//   }

//   Widget _renderLink() {
//     return TextButton(
//         onPressed: () {},
//         child: const Text(
//           'Forgot your Password?',
//           style:
//               TextStyle(color: Color.fromARGB(255, 21, 126, 251), fontSize: 12),
//         ));
//   }
//   // bool get _isPassValid {
//   //   if (_pass.length >= 8) {
//   //     return true;
//   //   } else {
//   //     return false;
//   //   }
//   // }

//   // bool get _isUsernameValid {
//   //   if (_username.isNotEmpty) {
//   //     return true;
//   //   } else {
//   //     return false;
//   //   }
//   // }

//   bool get _nameValidation {
//     return controllerUsername.text.isNotEmpty;
//   }
//   // for (final user in StorageUser.users) {
//   //   if (user.email == controllerUsername.text ||
//   //       user.username == controllerUsername.text) {
//   //     findingUser = user;
//   //     return true;
//   //   }
//   // }
//   // return false;

//   bool get _passwordValidation {
//     return controllerPassword.text.length > 7;
//   }
//   // for (final user in StorageUser.users) {
//   //   if (controllerPassword.text == user.password &&
//   //       controllerPassword.text.length > 8) {
//   //     return true;
//   //   }
//   // }
//   // return false;

//   bool get _isActive {
//     for (final user in StorageUser.users) {
//       if ((user.email == controllerUsername.text ||
//               user.username == controllerUsername.text) &&
//           controllerPassword.text == user.password) {
//         findingUser = user;
//         return true;
//       }
//     }
//     return false;
//   }
// }
