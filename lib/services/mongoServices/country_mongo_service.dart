import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/services/Api/api_service.dart';

import '../../model/country_model.dart';

class CountryMongoService {
  final MongoRealmClient client = MongoRealmClient();
  final RealmApp app = RealmApp();



  Future<void> insertCountries() async {

    final tokenPref = await SharedPreferences.getInstance();
    final realmToken = tokenPref.getString('realmToken')!;
    await RealmApp().login(Credentials.jwt(realmToken));
    var collection = client.getDatabase('myDb').getCollection('countries');
    // var document = MongoDocument(
    //   country.toMap(),
    // );
    await ApiService().loadCountries();
    await collection.insertMany( [
      ApiService().countriesListMongo!,
    ]);
  }


 

  Future<List<Country>> getCountries() async {
    final countryList = <Country>[];
    var collection = client.getDatabase('myDb').getCollection('countries');
   collection.find(filter: {})
    country.forEach((element) {
      countryList.add(Country.fromJson(element));
    // collection.find(filter: )
    // var docs =
    //     await collection.find(filter: {'name': userName, 'password': password});
   // final countryList = Country.fromJson(collection.);
    return countryList;
  }

  // Future<void> deleteUser(User user) async {
  //   var collection = client.getDatabase('myDb').getCollection('users');
  //   var deletedDocs = await collection.deleteOne({'name': user.name});
  // }

  // Future<void> updateUser(User user, _doc) async {
  //   var collection = client.getDatabase('myDb').getCollection('users');
  //   await collection.updateMany(
  //       filter: {'name': user.name}, update: UpdateOperator.set(_doc));
  // }
}
