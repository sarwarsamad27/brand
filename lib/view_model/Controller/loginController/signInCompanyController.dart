import 'package:brand/barrelView/barrelView.dart';

class SigninCompanyController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final comformKey = GlobalKey<FormState>();

  bool isObsecure = true;

  bool isLoading = false;

  void obsecuretext() {
    isObsecure = !isObsecure;
    notifyListeners();
  }
}
