import 'package:brand/barrelView/barrelView.dart';

class LogoutRepository extends ChangeNotifier {
  bool isLogoutDialogVisible = false;

  void showLogoutDialog() {
    isLogoutDialogVisible = true;
    notifyListeners();
  }

  void hideLogoutDialog() {
    isLogoutDialogVisible = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ✅ Remove all saved data

    isLogoutDialogVisible = false;
    notifyListeners();

    // ✅ Navigate back to Login Screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const UserLoginscreen()),
      (route) => false, // remove all previous routes
    );
  }
}
