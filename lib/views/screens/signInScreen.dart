import 'package:brand/barrelView/barrelView.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signIncontroller = Provider.of<Signincontroller>(context);
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
                key: signIncontroller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      controller: signIncontroller.nameController,
                      hintText: 'Name',
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      controller: signIncontroller.emailController,
                      hintText: 'Email...',
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message_outlined)),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      controller: signIncontroller.passwordController,
                      hintText: 'password',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      isObSecure: signIncontroller.isObsecure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          signIncontroller.obsecuretext();
                        },
                        icon: Icon(signIncontroller.isObsecure
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

                Navigator.pushNamed(context, RoutesName.loginScreen);
              },
              title: "Register",
              bgColor: AppColor.primaryColor,
              textStyle: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: AppFontSizes.font16,
              ),
              height: height * 0.07,
              // 7% of screen height for button height
              width: double.infinity,
            ),
            const SizedBox(height: 10.0),
            const CustomText(
              text: "OR",
              style: TextStyle(color: AppColor.textSecondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.loginScreen);
              },
              child: const CustomText(
                text: "Register as a user",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: "Already have an account?",
                  style: TextStyle(color: AppColor.textSecondaryColor),
                ),
                const SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.loginScreen);
                  },
                  child: const CustomText(
                    text: "Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
