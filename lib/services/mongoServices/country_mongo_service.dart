import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:snap_chat_copy/services/Api/api_repo.dart';

import '../../model/country_model.dart';

class CountryMongoService {
  final MongoRealmClient client = MongoRealmClient();
  final RealmApp app = RealmApp();

  Future<void> insertCountries(List<Country> countries) async {
    final mongodoc = <MongoDocument>[];
    countries.forEach((country) {
      mongodoc.add(MongoDocument(country.toMap()));
    });
    await client
        .getDatabase('myDb')
        .getCollection('countries')
        .insertMany(mongodoc);
  }

  Future<List<Country>> getCountries() async {
    final countriesList = <Country>[];
    final collection = client.getDatabase('myDb').getCollection('countries');
    final mongoDocs = await collection.find();

    if (mongoDocs.isEmpty) {
      final countries = await ApiRepo().loadCountries();
      await insertCountries(countries);
      countriesList.addAll(countries);
    } else {
      mongoDocs.forEach((docs) {
        countriesList.add(Country.fromMap(docs.map));
      });
    }
    return countriesList;
  }
}
