import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Repository/UserLogin_repository.dart';

class LoginController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  Future userLogin(BuildContext context) async {
    var res = await LoginRepository.userLogin(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    print("Response Map: $res");
    print("Code Status: ${res['code_status']}");
    print("Message: ${res['message']}");

    if (res != null && res['code_status'].toString().toLowerCase() == 'true') {
      emailController.clear();
      passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    } else {
      String message = res?['message'] ?? 'Something went wrong';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void _showDialog(BuildContext context, String title, String message,
      {VoidCallback? onOk}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              if (onOk != null) onOk();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
