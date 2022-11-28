import 'package:snap_chat_copy/services/mongoServices/country_mongo_service.dart';

import '../../model/country_model.dart';
import '../Api/api_repo.dart';

class CountryMongoRepo {
  CountryMongoService countryMongoService = CountryMongoService();
  List<Country> countryList = <Country>[];

  Future<List<Country>> getCountries() async {
    countryList = await CountryMongoService().getCountries();
    return countryList;
  }

  Future<Country?> getCountry() async {
    final userLocation = await ApiRepo().loadLocation();
    return userLocation;
  }
}
