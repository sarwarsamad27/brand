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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLogoutDialogVisible = false;
    notifyListeners();
  }
}
