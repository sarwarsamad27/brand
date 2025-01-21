import 'package:brand/barrelView/barrelView.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logincontroller = Provider.of<LoginController>(context);
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .03),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: logincontroller.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        controller: logincontroller.emailController,
                        hintText: 'Email...',
                        prefixIcon: const Icon(Icons.message_outlined),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      CustomTextField(
                        controller: logincontroller.passwordController,
                        hintText: 'password',
                        // errorText:
                        //     logincontroller.passwordController.text.length >= 6
                        //         ? null
                        //         : 'Password must be at least 6 characters',
                        prefixIcon: const Icon(Icons.lock),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        isObSecure: logincontroller.isObsecure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            logincontroller.togglePasswordVisibility();
                          },
                          icon: Icon(logincontroller.isObsecure
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_rounded

                              // logincontroller.isObsecure ? icons.eye : Assets.hideEye,
                              // height: width * 0.05, // 5% of screen width for icon size
                              // width: width * 0.05, // 5% of screen width for icon size
                              ),
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.forgotScreen);
                      },
                      child: const Text(
                        'forgot password?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ))
                ],
              ),
              SizedBox(
                height: height * .03,
              ),
              CustomButton(
                onTap: () {
                  // if (logincontroller.formKey.currentState!
                  //     .validate()) {
                  //   logincontroller.loginUser().then(
                  //     (value) {
                  //       Navigator.pushReplacementNamed(
                  //           context, RoutesName.homeScreen);
                  //     },
                  //   );
                  //   print("register ho gaya");
                  // }

                  Navigator.pushNamed(context, RoutesName.homeScreen);
                },
                title: "Log In",
                bgColor: AppColor.primaryColor,
                textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: AppFontSizes.font16,
                ),
                height: height * 0.07,
                // 7% of screen height for button height
                width: double.infinity,
              ),
              SizedBox(
                height: height * .06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signInScreen);
                    },
                    child: const Text(
                      "  " "Sign in",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
