import 'package:brand/barrelView/barrelView.dart';

import 'package:http/http.dart' as http;

// class PaymentProvider with ChangeNotifier {
//   TextEditingController amountController = TextEditingController();
//   bool _isProcessing = false;
//   String? _paymentStatus;

//   bool get isProcessing => _isProcessing;
//   String? get paymentStatus => _paymentStatus;

//   // Function to initiate payment
//   Future<void> initiatePayment({
//     required String amount,
//     required String userId,
//     required String method, // e.g., JazzCash, Easypaisa
//   }) async {
//     _isProcessing = true;
//     notifyListeners();

//     try {
//       // Replace this URL with your backend endpoint
//       final response = await http.post(
//         Uri.parse('https://your-backend-server.com/initiate-payment'),
//         body: {
//           'amount': amount,
//           'user_id': userId,
//           'method': method,
//         },
//       );

//       if (response.statusCode == 200) {
//         _paymentStatus = "Payment Successful!";
//       } else {
//         _paymentStatus = "Payment Failed!";
//       }
//     } catch (e) {
//       _paymentStatus = "Error: ${e.toString()}";
//     }

//     _isProcessing = false;
//     notifyListeners();
//   }

//   String? selectedPayment;
//   final List<String> paymentList = [
//     'JazzCash',
//     'easyPaisa',
//   ];

//   void dropDownChangeValue(String? newValue) {
//     selectedPayment = newValue;
//     notifyListeners();
//   }
// }

class PaymentProvider with ChangeNotifier {
  TextEditingController phoneNumberController = TextEditingController();
  bool _isProcessing = false;
  String? _paymentStatus;

  bool get isProcessing => _isProcessing;
  String? get paymentStatus => _paymentStatus;

  // Easypaisa Payment Method
  Future<void> initiateEasypaisaPayment({
    required String phoneNumber,
    required String amount,
  }) async {
    _isProcessing = true;
    notifyListeners();

    try {
      // Call your backend API for Easypaisa transaction
      final response = await http.post(
        Uri.parse('https://your-backend-server.com/easypaisa-payment'),
        body: {
          'phone_number': phoneNumber,
          'amount': amount,
        },
      );

      if (response.statusCode == 200) {
        _paymentStatus = "Payment Successful!";
      } else {
        _paymentStatus = "Payment Failed!";
      }
    } catch (e) {
      _paymentStatus = "Error: ${e.toString()}";
    }

    _isProcessing = false;
    notifyListeners();
  }
}
