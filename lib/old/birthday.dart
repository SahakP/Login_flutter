// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';
// import 'package:snap_chat_copy/email_phone.dart';
// import 'package:snap_chat_copy/widgets/back_button.dart';
// import 'package:snap_chat_copy/widgets/button_submit.dart';
// import 'package:snap_chat_copy/widgets/header.dart';

// import '../model/user_model.dart';

// class Birthday extends StatefulWidget {
//   const Birthday({required this.users, Key? key}) : super(key: key);

//   final User users;

//   @override
//   State<Birthday> createState() => _BirthdayState();
// }

// class _BirthdayState extends State<Birthday> {
//   TextEditingController controllerBirthday = TextEditingController();
//   //User users = User();
//   late DateTime validDate;

//   @override
//   void initState() {
//     final now = DateTime.now();
//     validDate = DateTime(now.year - 16, now.month, now.day);
//     super.initState();
//   }

//   final int sixteenYear = 16 * 365 * 24 * 60 * 60 * 1000;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           const BackBtn(blueWhite: true),
//           Column(
//             children: [
//               const Header(header: "When's youre birthday"),
//               _renderBirthdayTF(),
//               _renderBirthdayErrorMsg(),
//               _continueButton(),
//               _datePicker(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _renderBirthdayTF() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 40,
//         vertical: 0,
//       ),
//       child: TextField(
//           autofocus: true,
//           readOnly: true,
//           controller: controllerBirthday,
//           style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
//           decoration: InputDecoration(
//             labelText: 'BIRTHDAY',
//             labelStyle: const TextStyle(
//               color: Color.fromARGB(255, 154, 160, 167),
//             ),
//             hintText: _validFormatDate(),
//           )),
//     );
//   }

//   Widget _renderBirthdayErrorMsg() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 40,
//             vertical: 0,
//           ),
//           child: Text(
//             !_birthdayValidation ? 'must be greater than or equal 16 year' : '',
//             style: const TextStyle(
//                 color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//           ))
//     ]);
//   }

//   Widget _datePicker() {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 40,
//         right: 40,
//         bottom: 10,
//         top: 10,
//       ),
//       child: SizedBox(
//         height: 150,
//         child: CupertinoDatePicker(
//           mode: CupertinoDatePickerMode.date,
//           onDateTimeChanged: (value) {
//             setState(() {});
//             validDate = value;
//             controllerBirthday.text =
//                 DateFormat('dd MMMM yyyy').format(validDate);
//           },
//           initialDateTime: validDate,
//         ),
//       ),
//     );
//   }

//   Widget _continueButton() {
//     return Expanded(
//         child: Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: ButtonSubmit(
//               isActive: _birthdayValidation,
//               title: 'Continue',
//               onTap: () {
//                 widget.users.birthday = validDate;
//                 if (_birthdayValidation) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               EmailOrPhone(users: widget.users)));
//                 } else {
//                   return null;
//                 }
//               },
//             )));
//   }

//   bool get _birthdayValidation {
//     final nowDate = DateTime.now();
//     return nowDate.difference(validDate).inMilliseconds >= sixteenYear;
//   }

//   String _validFormatDate() {
//     final formatter = DateFormat('dd MMMM yyyy');
//     final formattedDate = formatter.format(validDate);
//     return formattedDate;
//   }
// }
