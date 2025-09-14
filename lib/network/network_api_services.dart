import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brand/exception/exceptions.dart';
import 'package:brand/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  @override
  Future<Map<String, dynamic>> postApi(
      String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      print('✅ API URL: $url');
      print('✅ Request Body: ${jsonEncode(body)}');
      print('✅ Status Code: ${response.statusCode}');
      print('✅ Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          // Try decoding response as JSON
          final decoded = jsonDecode(response.body);

          if (decoded is Map<String, dynamic>) {
            return decoded; // ✅ Return parsed JSON
          } else {
            // If decoded is not Map (rare case), wrap it
            return {
              'code_status': true,
              'message': decoded.toString(),
            };
          }
        } catch (e) {
          // If response is plain text (not JSON), handle it safely
          return {
            'code_status': true, // ✅ Treat 200 as success
            'message': response.body.replaceAll('"', ''),
          };
        }
      } else {
        return {
          'code_status': false,
          'message': 'Server Error: ${response.body}',
        };
      }
    } on InternetException {
      return {
        'code_status': false,
        'message': 'No Internet Connection',
      };
    } catch (e) {
      return {
        'code_status': false,
        'message': 'Exception: $e',
      };
    }
  }
}
