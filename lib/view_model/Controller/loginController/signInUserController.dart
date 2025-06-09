import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Repository/signUp_Repository.dart';
import 'package:flutter/scheduler.dart';

class SigninUsercontroller extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final userformKey = GlobalKey<FormState>();
  Future register(BuildContext context) async {
    var res = await SignUpRepository.register(
      nameController.text,
      emailController.text,
      passwordController.text,
    );

    if (res != null && res['code_status'] == true) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Register Successfully, Please Login'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(
                        context, RoutesName.userloginScreen); // Navigate
                  },
                ),
              ],
            );
          },
        );
      });
    } else {
      String message = res?['message'] ?? 'Something went wrong, try again';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('${message} Register failed, Please register again '),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      );
    }

    print(res);
  }

  bool isObsecure = true;

  bool isLoading = false;

  void obsecuretext() {
    isObsecure = !isObsecure;
    notifyListeners();
  }
}
