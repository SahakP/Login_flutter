import 'package:sqflite/sqflite.dart';

import '../repositiry/api_repo.dart';

class CountriesDataBase {
  static final CountriesDataBase countriesDataBase =
      CountriesDataBase._CountriesDataBase();
  CountriesDataBase._CountriesDataBase();

  factory CountriesDataBase() {
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
      final countries = await ApiRepo().loadCountries();
      countries.forEach((country) {
        countryDB!.insert(
          'countries',
          country.toMap(),
        );
      });
    }
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE countries (name STRING PRIMARY KEY NOT NULL, iso2_cc STRING ,e164_cc STRING )');
  }
}
