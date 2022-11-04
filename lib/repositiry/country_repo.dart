import 'package:snap_chat_copy/repositiry/api_repo.dart';

import '../model/country_model.dart';
import '../services/country_db_service.dart';

class CountryRepo {
  final countryDB = CountriesDataBase();
  final countryList = <Country>[];

  Future<List<Country>> getCountries() async {
    await countryDB.init();
    final country = await countryDB.countryDB!.query('countries');
    country.forEach((element) {
      countryList.add(Country.fromJson(element));
    });
    return countryList;
  }

  Future<Country?> getCountry() async {
    final location = await ApiRepo().loadLocation();
    final userLocation = countryList.firstWhere(
        (Country country) => country.countryName.contains(location));
    return userLocation;
  }
}
