import 'package:brand/barrelView/barrelView.dart';

class VerifyYourIdentityViewModel extends ChangeNotifier {
  TextEditingController passController = TextEditingController();
  bool passIsObsecure = false;

  void passObsecureText() {
    passIsObsecure = !passIsObsecure;
    notifyListeners();
  }
}
