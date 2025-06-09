import 'dart:convert';

import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class SignUpRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.SignUp;

  static Future register(String name, String email, String password) async {
    try {
      final response = await apiService.postApi(apiurl, {
        "username": name,
        "emailAddress": email,
        "password": password,
      });

      print('Response status: ${response.statusCode}');
      print('Raw response body: ${response.body}');

      // Try parsing JSON
      try {
        final jsonBody = json.decode(response.body);
        if (jsonBody is Map<String, dynamic>) {
          return jsonBody;
        }
      } catch (_) {
        // If it's not JSON, return success manually if it's a 200 or 201
        if (response.statusCode == 200 || response.statusCode == 201) {
          return {
            'code_status': true,
            'message': response.body, // e.g. "User Registered Successfully"
          };
        } else {
          return {
            'code_status': false,
            'message': response.body,
          };
        }
      }

      return {
        'code_status': false,
        'message': 'Unexpected server response',
      };
    } catch (e) {
      return {
        'code_status': false,
        'message': 'Error occurred: $e',
      };
    }
  }
}
