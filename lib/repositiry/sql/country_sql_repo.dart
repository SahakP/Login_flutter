// import 'package:snap_chat_copy/services/Api/api_service.dart';

// import '../../model/country_model.dart';
// import '../../services/sqlServices/country_sql_service.dart';

// class CountrySqlRepo {
//   var countryList = <Country>[];

//   Future<List<Country>> getCountries() async {
//     countryList = await CountriesSqlService().getCountries();
//     return countryList;
//   }

//   Future<Country?> getCountry() async {
//     await getCountries();
//     final location = await ApiService().loadLocation();
//     final userLocation = countryList.firstWhere(
//         (Country country) => country.countryName.contains(location));
//     return userLocation;
//   }
// }
