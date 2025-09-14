import 'package:brand/barrelView/barrelView.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logincontroller = Provider.of<LoginController>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/imageIcon.webp', scale: 1,
                  // height: height * 0.2,
                ),
                CustomContainer(
                  height: height * .05,
                  width: width * .5,
                  bgColor: AppColor.appimagecolor,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () =>
                      Navigator.pushNamed(context, RoutesName.comLogInScreen),
                  child: Center(
                      child: Text(
                    'Login as Company',
                    style: TextStyle(
                        color: AppColor.whiteColor, fontSize: height * .02),
                  )),
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: logincontroller.emailController,
                  hintText: 'Email...',
                  prefixIcon: const Icon(
                    Icons.message_outlined,
                    color: AppColor.appimagecolor,
                  ),
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: logincontroller.passwordController,
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColor.appimagecolor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isObSecure: logincontroller.isObsecure,
                  suffixIcon: IconButton(
                    onPressed: () => logincontroller.togglePasswordVisibility(),
                    icon: Icon(
                      logincontroller.isObsecure
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_rounded,
                      color: AppColor.appimagecolor,
                    ),
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RoutesName.forgotScreen),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(height: height * .03),
            CustomButton(
              title: logincontroller.isLoading ? "Please wait..." : "Log In",
              onTap: () => logincontroller.userLogin(context),
              bgColor: AppColor.appimagecolor,
              textStyle: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: AppFontSizes.font16,
              ),
              height: height * 0.07,
              width: double.infinity,
            ),
            SizedBox(height: height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    // final User? user = await logincontroller.handleSignIn();
                    // if (user != null) {
                    //   // User signed in successfully
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const Homescreen()));
                    //   // You can navigate to another screen or perform other actions here.
                    // }
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image(image: AssetImage('assets/images/google.png')),
                  ),
                ),
                SizedBox(
                  width: width * .04,
                ),
                InkWell(
                  onTap: () {},
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child:
                        Image(image: AssetImage('assets/images/facebook.png')),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, RoutesName.usersignInScreen),
                  child: const Text(
                    "  Sign in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.appimagecolor,
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
