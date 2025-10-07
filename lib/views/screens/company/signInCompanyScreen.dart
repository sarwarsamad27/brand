import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/loginController/signInCompanyController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninCompanyScreen extends StatelessWidget {
  const SigninCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signIncontroller = Provider.of<SigninCompanyController>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/imageIcon.webp', scale: 1),

              CustomTextField(
                controller: signIncontroller.nameController,
                hintText: 'Company Name',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: const Icon(FontAwesomeIcons.person,
                    color: AppColor.appimagecolor),
              ),
              SizedBox(height: height * .02),

              CustomTextField(
                controller: signIncontroller.emailController,
                hintText: 'Company Email...',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon:
                    const Icon(Icons.email, color: AppColor.appimagecolor),
              ),
              SizedBox(height: height * .02),

              CustomTextField(
                controller: signIncontroller.passwordController,
                hintText: 'Company Password',
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
                  ),
                ),
              ),
              SizedBox(height: height * .03),

              /// 🔥 Register Button
              signIncontroller.isLoading
                  ? const CircularProgressIndicator(
                      color: AppColor.appimagecolor)
                  : CustomButton(
                      onTap: () {
                        signIncontroller.registerCompany(context);
                      },
                      title: "Register",
                      bgColor: AppColor.appimagecolor,
                      textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: AppFontSizes.font16,
                      ),
                      height: height * 0.07,
                      width: double.infinity,
                    ),

              const SizedBox(height: 20.0),

              const CustomText(
                text: "OR",
                style: TextStyle(color: AppColor.textSecondaryColor),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20.0),

              CustomContainer(
                height: height * .05,
                width: width * .5,
                bgColor: AppColor.appimagecolor,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.usersignInScreen);
                },
                child: const Center(
                  child: Text(
                    'Register as a user',
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
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
      ),
    );
  }
}
