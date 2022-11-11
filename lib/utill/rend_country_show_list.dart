import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_chat_copy/notifier/change_notifier.dart';

import '../model/country_model.dart';

// ignore: must_be_immutable
class RenderCountryShowList extends StatefulWidget {
  RenderCountryShowList(
      {required this.searchText, required this.countriesList, super.key});
  String searchText;

  final List<Country> countriesList;
  //final Function(Country) country;
  // ValueNotifier<Country> valueNotif = ValueNotifier<Country>(
  //     Country(name: '', countryPhoneCode: '', countryName: ''));

  @override
  State<RenderCountryShowList> createState() => _RenderCountryShowListState();
}

class _RenderCountryShowListState extends State<RenderCountryShowList> {
  MyChangeNotifier get changeNotif =>
      Provider.of<MyChangeNotifier>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView.builder(
          itemCount: widget.countriesList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final selectedCountry = widget.countriesList[index];

            return (selectedCountry.name!
                        .toLowerCase()
                        .contains(widget.searchText.toString().toLowerCase()) ||
                    selectedCountry.countryPhoneCode
                        .contains(widget.searchText))
                ? InkWell(
                    onTap: () {
                      changeNotif.selectCountry(selectedCountry);
                      //changeNotif.selectCountry();
                      //selectCountry(selectedCountry: selectedCountry);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                      ),
                      child: Column(
                        children: [
                          Row(children: [
                            Text(
                              flagMaker(selectedCountry),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                selectedCountry.name!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              selectedCountry.countryPhoneCode,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ]),
                          Container(
                            height: 1,
                            color: const Color.fromARGB(255, 139, 139, 139),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  String flagMaker(Country country) {
    final flag = country.countryName.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }
}
