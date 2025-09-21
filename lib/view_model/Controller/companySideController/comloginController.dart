import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/companySideModels/comLoginModel.dart';
import 'package:brand/resources/global.dart';
import 'package:brand/view_model/Repository/CompanyRepository/comLoginRepository.dart';

class CompLoginController extends ChangeNotifier {
  TextEditingController comNameController = TextEditingController();
  TextEditingController comEmailController = TextEditingController();
  TextEditingController comPasswordController = TextEditingController();

  bool isObsecure = true;
  String? loginError;
  String? response;
  bool isLoading = false;
  ComLoginModel? loginModel;

  void togglePasswordVisibility() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    isLoading = true;
    loginError = null;
    response = null;
    notifyListeners();

    try {
      final result = await ComLoginRepository.comLogin(
        comNameController.text.trim(),
        comEmailController.text.trim(),
        comPasswordController.text.trim(),
      );

      if (result.company != null) {
        response = result.message ?? "Login Successful ✅";
        loginModel = result;

        // 🟢 Save userId and Name globally
        Global.loggedInCompanyId = result.company?.id ?? "";
        Global.loggedInCompanyName = result.company?.name ?? "";

        // 🟢 Save login locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString(
            "companyId", Global.loggedInCompanyId = result.company?.id ?? "");
        await prefs.setString("companyName",
            Global.loggedInCompanyName = result.company?.name ?? "");

        Navigator.pushReplacementNamed(context, RoutesName.comSideStartScreen);
      } else {
        loginError = result.message ?? "Invalid credentials ❌";
      }
    } catch (e) {
      loginError = "Login failed: $e";
    }

    isLoading = false;
    notifyListeners();
  }

  void disposeControllers() {
    comNameController.dispose();
    comEmailController.dispose();
    comPasswordController.dispose();
    super.dispose();
  }
}
