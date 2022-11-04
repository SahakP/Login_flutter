// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:snap_chat_copy/country_list.dart';
// import 'package:snap_chat_copy/model/country.dart';
// import 'package:snap_chat_copy/pick_username.dart';
// import 'package:snap_chat_copy/widgets/back_button.dart';
// import 'package:snap_chat_copy/widgets/button_submit.dart';
// import 'package:snap_chat_copy/widgets/header.dart';
// import 'package:snap_chat_copy/widgets/un_focused.dart';

// import 'model/user_model.dart';

// class EmailOrPhone extends StatefulWidget {
//   const EmailOrPhone({required this.users, super.key});

//   final User users;
//   @override
//   State<EmailOrPhone> createState() => _EmailOrPhoneState();
// }

// class _EmailOrPhoneState extends State<EmailOrPhone> {
//   Country? _currentLocation;

//   var _countries;

//   TextEditingController controllerEmail = TextEditingController();

//   TextEditingController controllerPhoneNumber = TextEditingController();
//   String flag = '';

//   bool _isOk = true;

//   @override
//   Widget build(BuildContext context) {
//     return _isOk ? _renderEmailPage() : _renderPhoneNumberPage();
//   }

//   Future<void> _loadCountries() async {
//     final response = await http
//         .get(Uri.parse('https://parentstree-server.herokuapp.com/countries'));

//     if (response.statusCode == 200) {
//       final countriesJson = jsonDecode(response.body)['countries'] as List;
//       _countries = countriesJson.map((e) => Country.fromJson(e)).toList();
//     }

//     final locale = await http.get(Uri.parse('http://ip-api.com/json'));
//     if (locale.statusCode == 200) {
//       final currentCountry = json.decode(locale.body)['countryCode'].toString();

//       _currentLocation = _countries.firstWhere(
//           (Country country) => country.iso2_cc.contains(currentCountry));

//       // print(currentCountry);
//       //print(_currentLocation);

//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     _loadCountries();
//     super.initState();
//   }

//   void _changePage() {
//     setState(() {
//       _isOk = !_isOk;
//     });
//   }

//   Widget _renderEmailPage() {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: UnFocusedWidget(
//             child: Stack(children: [
//           const BackBtn(blueWhite: true),
//           Column(
//             children: [
//               const Header(header: "What's youre email"),
//               _renderSignUpWithPhone(),
//               _renderEmailTF(),
//               _renderEmailErrorMsg(),
//               _continueButtonPN(),
//             ],
//           ),
//         ])));
//   }

//   Widget _renderPhoneNumberPage() {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: UnFocusedWidget(
//             child: Stack(children: [
//           const BackBtn(blueWhite: true),
//           Column(
//             children: [
//               const Header(
//                 header: "What's your \n mobile number?",
//               ),
//               _renderSignUpToEmail(),
//               _renderPhoneLabelText(),
//               _renderNumberInput(),
//               _lineContainer(),
//               _renderPhoneErrorMsg(),
//               _renderPhoneTextUnder(),
//               _phoneNumberButton(),
//             ],
//           )
//         ])));
//   }

//   Widget _renderNumberInput() {
//     return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//       Expanded(
//           child: Align(
//               alignment: FractionalOffset.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 35),
//                 child: _countryList(),
//               ))),
//       Expanded(
//           child: Align(
//               alignment: FractionalOffset.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 0),
//                 child: _renderPhoneNumberTF(),
//               ))),
//       const Expanded(
//           child: Align(
//         alignment: FractionalOffset.centerRight,
//         child: Text(''),
//       ))
//     ]);
//   }

//   Widget _renderEmailTF() {
//     return Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 40,
//           vertical: 0,
//         ),
//         child: TextField(
//           autofocus: true,
//           controller: controllerEmail,
//           onChanged: (value) {
//             widget.users.email = controllerEmail.text;
//             setState(() {});
//           },
//           style: const TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
//           decoration: const InputDecoration(
//             labelText: 'EMAIL',
//           ),
//         ));
//   }

//   Widget _renderEmailErrorMsg() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
//           child: Text(
//             !_emailValidation ? 'Enter Correct Email Address' : '',
//             style: const TextStyle(
//                 color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//           ))
//     ]);
//   }

//   Widget _renderPhoneTextUnder() {
//     return const Text(
//         style: TextStyle(
//           fontSize: 16,
//         ),
//         textAlign: TextAlign.center,
//         "We'll send you an SMS verification code.");
//   }

//   Widget _renderPhoneErrorMsg() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
//           child: Text(
//             !_phoneNumberValidation
//                 ? 'must be greater than or equal 1 symbol'
//                 : '',
//             style: const TextStyle(
//                 color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12),
//           ))
//     ]);
//   }

//   Widget _renderPhoneNumberTF() {
//     return TextField(
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//       ),
//       autofocus: true,
//       keyboardType: TextInputType.number,
//       controller: controllerPhoneNumber,
//       onChanged: (value) {
//         widget.users.phoneNumber = controllerPhoneNumber.text;
//         setState(() {});
//       },
//       style: const TextStyle(
//           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
//     );
//   }

//   Widget _renderPhoneLabelText() {
//     return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//       const Padding(
//           padding: EdgeInsets.only(left: 45, top: 10),
//           child: Text(
//             'MOBILE NUMBER',
//             style: TextStyle(
//                 color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
//           ))
//     ]);
//   }

//   Widget _renderSignUpToEmail() {
//     return TextButton(
//       onPressed: () => _changePage(),
//       child: const Text(
//         'Sign up with email instead',
//         style:
//             TextStyle(color: Color.fromARGB(255, 21, 126, 251), fontSize: 12),
//       ),
//     );
//   }

//   Widget _renderSignUpWithPhone() {
//     return TextButton(
//       onPressed: () => _changePage(),
//       child: const Text(
//         'Sign up with phone instead',
//         style:
//             TextStyle(color: Color.fromARGB(255, 21, 126, 251), fontSize: 12),
//       ),
//     );
//   }

//   Widget _countryList() {
//     return TextButton(
//       style: TextButton.styleFrom(
//         textStyle: const TextStyle(fontSize: 16),
//       ),
//       onPressed: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CountryList(
//                       countriesList: _countries,
//                       country: (Country _countries) {
//                         setState(() {});
//                         return _currentLocation = _countries;
//                       },
//                     )));
//       },
//       child: Text(flagMaker()),
//     );
//   }

//   String flagMaker() {
//     if (_currentLocation != null) {
//       final flag = _currentLocation!.iso2_cc.toUpperCase().replaceAllMapped(
//           RegExp(r'[A-Z]'),
//           (match) =>
//               String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

//       return flag + ' +' + _currentLocation!.e164_cc;
//     } else {
//       return '';
//     }
//   }

//   Widget _lineContainer() {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: Container(
//           height: 2,
//           color: const Color.fromARGB(255, 185, 193, 199),
//         ));
//   }

//   Widget _phoneNumberButton() {
//     return Expanded(
//         child: Align(
//       alignment: FractionalOffset.bottomCenter,
//       child: ButtonSubmit(
//         isActive: _phoneNumberValidation,
//         title: 'Continue',
//         onTap: () {
//           _phoneNumberValidation
//               ? Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PickUsername(users: widget.users)))
//               : null;
//         },
//       ),
//     ));
//   }

//   bool get _phoneNumberValidation {
//     if (controllerPhoneNumber.text.isNotEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool get _emailValidation {
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//         .hasMatch(controllerEmail.text);
//   }

//   Widget _continueButtonPN() {
//     return Expanded(
//         child: Align(
//       alignment: FractionalOffset.bottomCenter,
//       child: ButtonSubmit(
//         isActive: _emailValidation,
//         title: 'Continue',
//         onTap: () {
//           if (_emailValidation) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => PickUsername(
//                           users: widget.users,
//                         )));
//           } else {
//             return null;
//           }
//         },
//       ),
//     ));
//   }
// }
