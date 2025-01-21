import 'package:brand/barrelView/barrelView.dart';

class CreateNewPasswordViewModel extends ChangeNotifier {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool passIsObsecure = true;

  void passObsecureText() {
    passIsObsecure = !passIsObsecure;
    notifyListeners();
  }

  bool confirmPassIsObsecure = true;

  void confirmPassObsecure() {
    confirmPassIsObsecure = !confirmPassIsObsecure;
    notifyListeners();
  }
}
