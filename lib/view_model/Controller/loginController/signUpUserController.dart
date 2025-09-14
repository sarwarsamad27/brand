import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Repository/signUpUser_Repository.dart';
import 'package:flutter/scheduler.dart';

class SignUpUsercontroller extends ChangeNotifier {
  // TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // final GlobalKey<FormState> userformKey = GlobalKey<FormState>();
  Future register(BuildContext context) async {
    var res = await SignUpUserRepository.register(
      // nameController.text,
      emailController.text,
      passwordController.text,
    );

    print("Response Map: $res");
    print("Code Status: ${res['code_status']}");
    print("Message: ${res['message']}");

    if (res != null && res['code_status'].toString().toLowerCase() == 'true') {
      // nameController.clear();
      emailController.clear();
      passwordController.clear();

      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: Text('${res['message'] ?? 'Registered Successfully!'}'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.userloginScreen);
                  },
                ),
              ],
            );
          },
        );
      });
    } else {
      String message = res?['message'] ?? 'Something went wrong';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  bool isObsecure = true;

  bool isLoading = false;

  void obsecuretext() {
    isObsecure = !isObsecure;
    notifyListeners();
  }
}
