import 'package:brand/barrelView/barrelView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInUserScreen extends StatelessWidget {
  const SignInUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signIncontroller = Provider.of<SigninUsercontroller>(context);
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/imageIcon.webp', scale: 1,
                  // height: height * 0.2,
                ),
                CustomTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: signIncontroller.nameController,
                  hintText: 'User Name',
                  prefixIcon: const Icon(
                    FontAwesomeIcons.person,
                    color: AppColor.appimagecolor,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: signIncontroller.emailController,
                  hintText: 'User Email...',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColor.appimagecolor,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  controller: signIncontroller.passwordController,
                  hintText: 'User password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isObSecure: signIncontroller.isObsecure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      signIncontroller.obsecuretext();
                    },
                    icon: Icon(
                      signIncontroller.isObsecure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColor.appimagecolor,

                      // logincontroller.isObsecure ? icons.eye : Assets.hideEye,
                      // height: width * 0.05, // 5% of screen width for icon size
                      // width: width * 0.05, // 5% of screen width for icon size
                    ),
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .03,
            ),
            CustomButton(
              onTap: () {
                if (signIncontroller.userformKey.currentState!.validate()) {
                  signIncontroller.register(context);
                  print("register ho gaya");
                }

                // Navigator.pushNamed(context, RoutesName.loginScreen);
              },
              title: "Register",
              bgColor: AppColor.appimagecolor,
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
                Navigator.pushNamed(context, RoutesName.signinCompanyScreen);
              },
              child: CustomContainer(
                height: height * .05,
                width: width * .5,
                bgColor: AppColor.appimagecolor,
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.pushNamed(
                    context, RoutesName.signinCompanyScreen),
                child: Center(
                    child: Text(
                  'Register as a company',
                  style: TextStyle(
                      color: AppColor.whiteColor, fontSize: height * .02),
                )),
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
                    Navigator.pushNamed(context, RoutesName.userloginScreen);
                  },
                  child: const CustomText(
                    text: "Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
