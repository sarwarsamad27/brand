import 'package:brand/barrelView/barrelView.dart';

class Onboardcontroller extends ChangeNotifier {
  final boardingController = PageController();
  bool isLast = false;

  void isTrue() {
    isLast = true;
    notifyListeners();
  }

  void isFalse() {
    isLast = false;
    notifyListeners();
  }

  void submit(BuildContext context) async {
    await CacheHelper.saveData(key: 'onBoarding', value: true);
    Navigator.pushNamed(
        context, RoutesName.loginScreen); // Navigate to the login screen
    notifyListeners(); // Notify listeners if needed for state management
  }
}
