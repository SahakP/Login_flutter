import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/model/country_model.dart';

import '../model/user_model.dart';
import 'constant.dart';

class ApiRepo {
  Future<List<Country>> loadCountries() async {
    var _countries = <Country>[];
    final response = await http
        .get(Uri.parse('https://parentstree-server.herokuapp.com/countries'));

    if (response.statusCode == 200) {
      final countriesJson = jsonDecode(response.body)['countries'] as List;
      _countries = countriesJson.map((e) => Country.fromJson(e)).toList();
    }
    return _countries;
  }

  Future<String> loadLocation() async {
    var currentCountry = '';
    final locale = await http.get(Uri.parse('http://ip-api.com/json'));
    if (locale.statusCode == 200) {
      currentCountry = json.decode(locale.body)['countryCode'].toString();
    }
    return currentCountry;
  }

  Future<User> addUser(User user) async {
    //make uri
    Uri? addUserUrl = Uri.parse('${ApiConstant.baseUrl}/addUser');
    //make header
    Map<String, String>? header = {'Content-Type': 'application/json'};
    //declare SheredPreferences
    final tokenPref = await SharedPreferences.getInstance();
    //make body
    final body = jsonEncode({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'password': user.password,
      'email': user.email,
      'phone': user.phone,
      'name': user.name,
      'birthDate': user.birthday.toString()
    });
    //check statusCode
    final response = await http.post(addUserUrl, headers: header, body: body);
    if (response.statusCode == 200) {
      //get tocken from body
      String token = jsonDecode(response.body)['createdTokenForUser'];
      //save token in SharedPreferences
      tokenPref.setString('token', token);

      //get user from body
      user = User.fromJson((jsonDecode(response.body))['user']);
    }
    return user;
  }

  Future<bool> checkName(String name) async {
    Uri? nameChackUrl = Uri.parse('${ApiConstant.baseUrl}/check/name');
    final body = jsonEncode({'name': name});
    Map<String, String>? header = {'Content-Type': 'application/json'};

    final response = await http.post(nameChackUrl, headers: header, body: body);
    if (response.statusCode == 200) {}
    // else{
    //   if(response.statusCode == 500){

    //   }

    // }
    return true;
  }

  Future<bool> checkEmail(String email) async {
    Uri? emailCheckUrl = Uri.parse('${ApiConstant.baseUrl}/check/email');
    final body = jsonEncode({'email': email});
    Map<String, String>? header = {'Content-Type': 'application/json'};

    final response =
        await http.post(emailCheckUrl, headers: header, body: body);
    if (response.statusCode == 200) {}
    // else{
    //   if(response.statusCode == 500){
    //   }
    // }
    return true;
  }

  Future<bool> checkPhone(String phone) async {
    Uri? phoneCheckUrl = Uri.parse('${ApiConstant.baseUrl}/check/phone');
    final body = jsonEncode({'phone': phone});
    Map<String, String>? header = {'Content-Type': 'application/json'};

    final response =
        await http.post(phoneCheckUrl, headers: header, body: body);
    if (response.statusCode == 200) {}
    // else{
    //   if(response.statusCode == 500){
    //   }
    // }
    return true;
  }

  Future<User?> signin(String login, String password) async {
    Uri? signinUrl = Uri.parse('${ApiConstant.baseUrl}/signin');
    Map<String, String>? header = {'Content-Type': 'application/json'};
    final body = jsonEncode({'login': login, 'password': password});
    final tokenPref = await SharedPreferences.getInstance();
    var user;
    final response = await http.post(signinUrl, headers: header, body: body);
    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)['createdTokenForUser'];
      tokenPref.setString('token', token);
      user = User.fromJson((jsonDecode(response.body))['user']);
    }
    return user;
  }

  Future<User?> getUser() async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.getString('token');

    Uri? userUri = Uri.parse('${ApiConstant.baseUrl}/me');

    Map<String, String>? header = {'token': token!};

    User? user;

    final response = await http.get(userUri, headers: header);

    if (response.statusCode == 200) {
      user = User.fromJson(jsonDecode(response.body)['user']);
    }
    return user;
  }
}
