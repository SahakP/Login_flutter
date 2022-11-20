import 'package:snap_chat_copy/services/Api/api_service.dart';
import 'package:snap_chat_copy/services/sqlServices/country_sql_service.dart';

import '../../model/country_model.dart';

class CountrySqlRepo {
  final countryList = <Country>[];

  Future<List<Country>> getCountries() async {
    await CountriesSqlService().getCountries();
    return countryList;
  }

  Future<Country?> getCountry() async {
    await getCountries();
    final location = await ApiService().loadLocation();
    final userLocation = countryList.firstWhere(
        (Country country) => country.countryName.contains(location));
    return userLocation;
  }
}
