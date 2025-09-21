import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Repository/UserRepository/UserLogin_repository.dart';

class UserLoginController with ChangeNotifier {
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

  Future<void> userLogin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final res = await LoginRepository.userLogin(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    _isLoading = false;
    notifyListeners();

    if (res != null && res.message!.contains("Login successful")) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", res.user?.id ?? "");
      await prefs.setString("email", res.user?.email ?? "");
      print("✅ Saved userId: ${res.user?.id}");

      clearControllers();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    } else {
      _showDialog(context, "Error", res?.message ?? "Something went wrong");
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
