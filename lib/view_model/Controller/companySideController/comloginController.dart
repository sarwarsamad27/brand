import 'package:brand/barrelView/barrelView.dart';

class CompLoginController extends ChangeNotifier {
  TextEditingController comEmailController = TextEditingController();
  TextEditingController comNameController = TextEditingController();
  TextEditingController comPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObsecure = true;
  String? loginError;
  String? response;
  bool isLoading = false;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  // Validate email using regex
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
    return emailRegex.hasMatch(email);
  }

  // Validate password (min 6 characters)
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Handle login action
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    loginError = null;
    notifyListeners();

    // Simulating network delay for login
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with actual login logic (API call, etc.)
    if (isValidEmail(comEmailController.text) &&
        isValidPassword(comPasswordController.text)) {
      response = 'Login Successful';
      loginError = null;
    } else {
      response = null;
      loginError = 'Invalid email or password';
    }

    isLoading = false;
    notifyListeners();
  }

  // Dispose controllers
  void disposeControllers() {
    comEmailController.dispose();
    comPasswordController.dispose();
    super.dispose();
  }
}
