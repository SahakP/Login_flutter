import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:snap_chat_copy/model/country_model.dart';
import 'package:snap_chat_copy/repositiry/validation/validation_repository.dart';
import 'package:snap_chat_copy/repositiry/Api/api_repo.dart';
import 'package:snap_chat_copy/utill/back_button.dart' show BackBtn;
import 'package:snap_chat_copy/utill/button_submit.dart';
import 'package:snap_chat_copy/utill/country_list.dart';
import 'package:snap_chat_copy/utill/header.dart';
import 'package:snap_chat_copy/utill/un_focused.dart';

import '../../model/user_model.dart';
import '../../notifier/change_notifier.dart';
import '../username/username_screen.dart';
import 'bloc/email_phone_bloc.dart';

class EmailOrPhone extends StatefulWidget {
  const EmailOrPhone({required this.user, super.key});
  final User user;

  @override
  State<EmailOrPhone> createState() => _EmailOrPhoneState();
}

class _EmailOrPhoneState extends State<EmailOrPhone> {
  final _bloc = EmailPhoneBloc(validRepo: ValidationRepo(), apiRepo: ApiRepo());

  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isLoading = false;
  Country? _selectedCountry;

  MyChangeNotifier get changeNotif =>
      Provider.of<MyChangeNotifier>(context, listen: false);

  // ValueNotifier<Country> valueNotif = ValueNotifier<Country>(
  //     Country(name: '', countryPhoneCode: '', countryName: ''));

  List<Country> _countries = [];

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  String phoneExpMsg = 'usernaemErrorMsg'.i18n();
  String emailExpMsg = 'emailErrorMsg'.i18n();
  bool _isEmail = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<EmailPhoneBloc, EmailPhoneState>(
          listener: _listener,
          child: BlocBuilder<EmailPhoneBloc, EmailPhoneState>(
            builder: _isEmail ? _renderEmail : _renderPhone,
          ),
        ));
  }

  @override
  void initState() {
    _bloc.add(EmailPhoneLoadCountresEvent());
    changeNotif.addListener(_onChange);
    super.initState();
  }

  Widget _renderEmail(context, state) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: UnFocusedWidget(
            child: Stack(children: [
          const BackBtn(blueWhite: true),
          Column(
            children: [
              Header(header: 'whatsYoureEmail'.i18n()),
              _renderSignUpWithPhone(),
              _renderEmailTF(),
              _renderEmailErrorMsg(),
              _renderEmailButton(),
            ],
          ),
        ])));
  }

  Widget _renderPhone(context, state) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: UnFocusedWidget(
            child: Stack(children: [
          const BackBtn(blueWhite: true),
          Column(
            children: [
              Header(
                header: 'whatsYourMobileNumber'.i18n(),
              ),
              _renderSignUpToEmail(),
              _renderPhoneLabelText(),
              _renderNumberInput(),
              _renderLineContainer(),
              _renderPhoneErrorMsg(),
              _renderPhoneTextUnder(),
              _phoneNumberButton(),
            ],
          )
        ])));
  }

  Widget _renderNumberInput() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Align(
              alignment: FractionalOffset.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 35),
                child: _countryList(),
              ))),
      Expanded(
          child: Align(
              alignment: FractionalOffset.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: _renderPhoneNumberTF(),
              ))),
      const Expanded(
          child: Align(
        alignment: FractionalOffset.centerRight,
        child: Text(''),
      ))
    ]);
  }

  Widget _renderEmailTF() {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 0,
        ),
        child: TextField(
          autofocus: true,
          controller: controllerEmail,
          onChanged: (value) {
            _bloc.add(EmailEvent(email: value));
          },
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          decoration: InputDecoration(labelText: 'EMAIL'.i18n()),
        ));
  }

  Widget _renderEmailErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
          child: Text(
            emailExpMsg,
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderPhoneTextUnder() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
            'smsVerification'.i18n(),
          ),
        ));
  }

  Widget _renderPhoneErrorMsg() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
          child: Text(
            phoneExpMsg,
            style: const TextStyle(
                color: Color.fromARGB(255, 185, 193, 199),
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ))
    ]);
  }

  Widget _renderPhoneNumberTF() {
    return TextField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      autofocus: true,
      keyboardType: TextInputType.number,
      controller: controllerPhoneNumber,
      onChanged: (value) {
        _bloc.add(PhoneEvent(phone: controllerPhoneNumber.text));
      },
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _renderPhoneLabelText() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 45, top: 10),
          child: Text(
            'MOBILENUMBER'.i18n(),
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
          ))
    ]);
  }

  Widget _renderSignUpToEmail() {
    return TextButton(
      onPressed: () => _changePage(),
      child: Text(
        'signUpWithEmail'.i18n(),
        style: const TextStyle(
            color: Color.fromARGB(255, 21, 126, 251), fontSize: 12),
      ),
    );
  }

  Widget _renderSignUpWithPhone() {
    return TextButton(
      onPressed: () => _changePage(),
      child: Text(
        'signUpWithPhone'.i18n(),
        style: const TextStyle(
            color: Color.fromARGB(255, 21, 126, 251), fontSize: 12),
      ),
    );
  }

  Widget _countryList() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                    value: changeNotif,
                    child: CountryList(
                      //valueNotif: changeNotif,
                      countriesList: _countries,
                    ))));
      },
      child: isLoading ? Text(flagMaker()) : const CupertinoActivityIndicator(),
    );
  }

  String flagMaker() {
    final country = _selectedCountry;
    if (country == null) {
      return '';
    }

    final flag = country.countryName.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag + ' +' + country.countryPhoneCode;
  }

  Widget _renderLineContainer() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          height: 2,
          color: const Color.fromARGB(255, 185, 193, 199),
        ));
  }

  Widget _phoneNumberButton() {
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: ButtonSubmit(
        isActive: isPhoneValid,
        title: 'Continue'.i18n(),
        onTap: () {
          isPhoneValid && isLoading
              ? {
                  widget.user.phone = _selectedCountry!.countryPhoneCode +
                      ' ' +
                      controllerPhoneNumber.text,
                  widget.user.email = '',
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UsernameScreen(users: widget.user)))
                }
              : null;
        },
      ),
    ));
  }

  void _onChange() {
    _selectedCountry = changeNotif.country;
    setState(() {});
  }

  Widget _renderEmailButton() {
    return Expanded(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: ButtonSubmit(
        isActive: isEmailValid,
        title: 'Continue'.i18n(),
        onTap: () {
          isEmailValid
              ? {
                  widget.user.email = controllerEmail.text,
                  widget.user.phone = '',
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsernameScreen(
                                users: widget.user,
                              )))
                }
              : null;
        },
      ),
    ));
  }

  void _changePage() {
    setState(() {
      _isEmail = !_isEmail;
    });
  }
}

extension _BlocListener on _EmailOrPhoneState {
  void _listener(context, state) {
    if (state is EmailSuccessState) {
      emailExpMsg = state.emailExpMsg;
      isEmailValid = state.isEmailValid;
    }

    if (state is EmailCheckState) {
      emailExpMsg = state.emailExpMsg;
      isEmailValid = state.isEmailValid;
    }

    if (state is PhoneSuccessState) {
      phoneExpMsg = state.phoneExpMsg;
      isPhoneValid = state.isPhoneValid;
    }

    if (state is PhoneCheckState) {
      phoneExpMsg = state.phoneExpMsg;
      isPhoneValid = state.isPhoneValid;
    }

    if (state is LoadinState) {}

    if (state is EmailPhoneLoadCountresState) {
      _selectedCountry = state.currentLocation;
      _countries = state.countries;
      isLoading = true;
    }
  }
}
