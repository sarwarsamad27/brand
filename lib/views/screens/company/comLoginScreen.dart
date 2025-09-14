import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/comloginController.dart';

class Comloginscreen extends StatelessWidget {
  const Comloginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logincontroller = Provider.of<CompLoginController>(context);
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
                  'assets/images/imageIcon.png', scale: 1,
                  // height: height * 0.2,
                ),
                CustomContainer(
                  height: height * .05,
                  width: width * .5,
                  bgColor: AppColor.appimagecolor,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () =>
                      Navigator.pushNamed(context, RoutesName.userloginScreen),
                  child: Center(
                      child: Text(
                    'Login as user',
                    style: TextStyle(
                        color: AppColor.whiteColor, fontSize: height * .02),
                  )),
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: logincontroller.comNameController,
                  hintText: 'Company Name',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColor.appimagecolor,
                  ),
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: logincontroller.comEmailController,
                  hintText: 'Email...',
                  prefixIcon: const Icon(
                    Icons.message_outlined,
                    color: AppColor.appimagecolor,
                  ),
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: logincontroller.comPasswordController,
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
              onTap: () =>
                  Navigator.pushNamed(context, RoutesName.comSideStartScreen),
              title: "Log In",
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
                  onTap: () => Navigator.pushNamed(
                      context, RoutesName.signinCompanyScreen),
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
