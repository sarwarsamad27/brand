// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:convert';

import 'package:brand/exception/exceptions.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  };
  @override
  Future<dynamic> postApi(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        print(body);
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } on InternetException {
      return print("Something Went Wrong!");
    }
  }
}
