import 'package:brand/barrelView/barrelView.dart';

class Signincontroller extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isObsecure = true;

  bool isLoading = false;

  void obsecuretext() {
    isObsecure = !isObsecure;
    notifyListeners();
  }
}
