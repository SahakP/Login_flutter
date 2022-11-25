import 'dart:convert';

class ResponseModel {
  int? statusCode;
  String? msg;

  ResponseModel({this.statusCode, this.msg});

  void toMassage(String body) {
    final a = jsonDecode(body) as Map<String, dynamic>;
    msg = a.values.first.toString();
  }
}
