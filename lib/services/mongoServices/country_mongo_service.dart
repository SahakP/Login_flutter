import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/model/country_model.dart';
import 'package:snap_chat_copy/services/Api/api_service.dart';

class CountryMongoService {
  final MongoRealmClient client = MongoRealmClient();
  final RealmApp app = RealmApp();



  Future<void> insertData(Country country) async {

   var countryList = ApiService().loadCountries();
    final tokenPref = await SharedPreferences.getInstance();
    final realmToken = tokenPref.getString('realmToken')!;
    await RealmApp().login(Credentials.jwt(realmToken));

    var collection = client.getDatabase('myDb').getCollection('countries');

    var document = MongoDocument(
      country.toMap(),
    );
    ApiService

    await collection.insertMany( [
      MongoDocument( country.toMap()),
    ]);
  }
   Future<Map<int, ObjectId>> insertMany(List<MongoDocument> documents) async {
    Map results = await (FlutterMongoRealm.insertDocuments(
      collectionName: this.collectionName,
      databaseName: this.databaseName,
      list: documents.map((doc) => jsonEncode(doc.map)).toList(),
    ));

    return results.map<int, ObjectId>(
        (key, value) => MapEntry<int, ObjectId>(key, ObjectId.parse(value)));
  }

  Future<List<Country>> getCountries() async {
    var collection = client.getDatabase('myDb').getCollection('countries');
    
    // collection.find(filter: )
    // var docs =
    //     await collection.find(filter: {'name': userName, 'password': password});
    final countryList = Country.fromJson(collection.);
    return countryList;
  }

  Future<void> deleteUser(User user) async {
    var collection = client.getDatabase('myDb').getCollection('users');
    var deletedDocs = await collection.deleteOne({'name': user.name});
  }

  Future<void> updateUser(User user, _doc) async {
    var collection = client.getDatabase('myDb').getCollection('users');
    await collection.updateMany(
        filter: {'name': user.name}, update: UpdateOperator.set(_doc));
  }
}
