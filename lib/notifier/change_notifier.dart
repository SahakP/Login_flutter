import 'package:flutter/cupertino.dart';

import '../model/country_model.dart';

class MyChangeNotifier extends ChangeNotifier {
  Country? country;

  void selectCountry(Country selectedCountry) {
    country = selectedCountry;
    notifyListeners();
  }
}
