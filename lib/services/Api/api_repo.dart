import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/model/country_model.dart';
import 'package:snap_chat_copy/model/response_model.dart';

import '../../model/user_model.dart';
import '../../utill/constant.dart';

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

  Future<Country> loadLocation() async {
    final countryList = await loadCountries();
    var currentCountry = '';
    final locale = await http.get(Uri.parse('http://ip-api.com/json'));
    if (locale.statusCode == 200) {
      currentCountry = json.decode(locale.body)['countryCode'].toString();
    }
    final userLocation = countryList.firstWhere(
        (Country country) => country.countryName.contains(currentCountry));
    return userLocation;
  }

  Future<User> addUser(User user) async {
    //make uri
    final Uri? addUserUrl = Uri.parse('${Constant.baseUrl}/addUser');
    //make header
    final header = {'Content-Type': 'application/json'};
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
    final response = await http.post(addUserUrl!, headers: header, body: body);
    if (response.statusCode == 200) {
      //get tocken from body
      final token = jsonDecode(response.body)['createdTokenForUser'];
      await tokenPref.setString('token', token);

      final realmToken = jsonDecode(response.body)['realmToken'];
      await tokenPref.setString('realmToken', realmToken);

      //get user from body
      user = User.fromJson((jsonDecode(response.body))['user']);
    }
    return user;
  }

  Future<User?> editUer(User user) async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.getString('token');

    final Uri? editeUserUrl = Uri.parse('${Constant.baseUrl}/editAccount');

    final Map<String, String>? header = {
      'token': token!,
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      'firstName': user.firstName,
      'password': user.password,
      'email': user.email,
      'lastName': user.lastName,
      'phone': user.phone,
      'name': user.name,
      'birthDate': user.birthday.toString()
    });

    final response =
        await http.post(editeUserUrl!, headers: header, body: body);
    if (response.statusCode == 200) {
      return user;
    } else {
      return null;
    }
  }

  Future<ResponseModel> checkName(String name) async {
    final Uri? nameCheckUrl = Uri.parse('${Constant.baseUrl}/check/name');
    final body = jsonEncode({'name': name});
    final Map<String, String>? header = {'Content-Type': 'application/json'};

    final response =
        await http.post(nameCheckUrl!, headers: header, body: body);
    final resMod = ResponseModel()
      ..statusCode = response.statusCode
      ..toMassage(response.body);
    return resMod;
  }

  Future<ResponseModel> checkEmail(String email) async {
    final Uri? emailCheckUrl = Uri.parse('${Constant.baseUrl}/check/email');
    final body = jsonEncode({'email': email});
    final Map<String, String>? header = {'Content-Type': 'application/json'};

    final response =
        await http.post(emailCheckUrl!, headers: header, body: body);
    final resMod = ResponseModel()
      ..statusCode = response.statusCode
      ..toMassage(response.body);

    return resMod;
  }

  Future<ResponseModel> checkPhone(String phone) async {
    final Uri? phoneCheckUrl = Uri.parse('${Constant.baseUrl}/check/phone');
    final body = jsonEncode({'phone': phone});
    final Map<String, String>? header = {'Content-Type': 'application/json'};

    final response =
        await http.post(phoneCheckUrl!, headers: header, body: body);
    final resMod = ResponseModel()
      ..statusCode = response.statusCode
      ..toMassage(response.body);

    return resMod;
  }

  Future<User?> signin(String login, String password) async {
    final signinUrl = Uri.parse('${Constant.baseUrl}/signin');
    final Map<String, String>? header = {'Content-Type': 'application/json'};
    final body = jsonEncode({'login': login, 'password': password});

    final tokenPref = await SharedPreferences.getInstance();
    User? user;

    final response = await http.post(signinUrl, headers: header, body: body);
    if (response.statusCode == 200) {
      final String token = jsonDecode(response.body)['createdTokenForUser'];
      tokenPref.setString('token', token);

      final String realmToken = jsonDecode(response.body)['realmToken'];
      tokenPref.setString('realmToken', realmToken);

      user = User.fromJson((jsonDecode(response.body))['user']);
    }
    return user;
  }

  Future<User?> getUser() async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.getString('token');

    final Uri? userUri = Uri.parse('${Constant.baseUrl}/me');

    final Map<String, String>? header = {'token': token!};

    User? user;

    final response = await http.get(userUri!, headers: header);

    if (response.statusCode == 200) {
      user = User.fromJson(jsonDecode(response.body)['user']);
    }
    return user;
  }

  Future<void> deleteUser() async {
    final tokenPref = await SharedPreferences.getInstance();
    final token = tokenPref.getString('token');
    final Uri? deleteUri = Uri.parse('${Constant.baseUrl}/delete/user');

    final Map<String, String>? header = {'token': token!};
    final response = await http.delete(deleteUri!, headers: header);
    if (response.statusCode == 200) {
      tokenPref.remove(token);
    }
  }
}
