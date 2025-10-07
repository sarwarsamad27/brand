import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/companySideModels/comRegisterModel.dart';
import 'package:brand/view_model/Repository/CompanyRepository/comRegisterRepository.dart';

class SigninCompanyController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObsecure = true;
  bool isLoading = false;

  void obsecuretext() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  /// 🚀 Register Function
  Future<ComRegisterModel?> registerCompany(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ComSignUpRepository.comRegister(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      isLoading = false;
      notifyListeners();

      if (response.user != null) {
        // ✅ Registration success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Registered: ${response.user!.email}")),
        );

        Navigator.pushReplacementNamed(context, RoutesName.comFormScreen);
      } else {
        // ❌ Failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? "Registration failed")),
        );
      }

      return response;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
      return null;
    }
  }
}
