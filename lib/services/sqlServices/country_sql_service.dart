import 'package:snap_chat_copy/services/Api/api_service.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/country_model.dart';

class CountriesSqlService {
  static final CountriesSqlService countriesDataBase =
      CountriesSqlService._CountriesDataBase();
  CountriesSqlService._CountriesDataBase();

  factory CountriesSqlService() {
    return countriesDataBase;
  }

  Database? countryDB;

  Future<void> init() async {
    try {
      if (countryDB != null) {
        return;
      }
      countryDB = await openDatabase(
          await getDatabasesPath() + 'countries21.db',
          version: 1,
          onCreate: onCreate);
      // ignore: empty_catches
    } catch (e) {}
    final countries = await countryDB!.query('countries');
    if (countries.isEmpty) {
      final countries = await ApiService().loadCountries();
      countries.forEach((country) {
        countryDB!.insert(
          'countries',
          country.toMap(),
        );
      });
    }
  }

  Future<List<Country>> getCountries() async {
    final countryList = <Country>[];
    await init();
    final country = await countryDB!.query('countries');
    country.forEach((element) {
      countryList.add(Country.fromJson(element));
    });
    return countryList;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE countries (name STRING PRIMARY KEY NOT NULL, iso2_cc STRING ,e164_cc STRING )');
  }
}
