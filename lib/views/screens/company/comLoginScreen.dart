import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/comloginController.dart';

class ComLoginScreen extends StatelessWidget {
  const ComLoginScreen({super.key});

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
            Image.asset('assets/images/imageIcon.png'),
            SizedBox(height: height * .03),

            // Name Field
            CustomTextField(
              controller: logincontroller.comNameController,
              hintText: 'Company Name',
              prefixIcon:
                  const Icon(Icons.person, color: AppColor.appimagecolor),
            ),
            SizedBox(height: height * .02),

            // Email Field
            CustomTextField(
              controller: logincontroller.comEmailController,
              hintText: 'Email...',
              prefixIcon:
                  const Icon(Icons.email, color: AppColor.appimagecolor),
            ),
            SizedBox(height: height * .02),

            // Password Field
            CustomTextField(
              controller: logincontroller.comPasswordController,
              hintText: 'Password',
              isObSecure: logincontroller.isObsecure,
              prefixIcon: const Icon(Icons.lock, color: AppColor.appimagecolor),
              suffixIcon: IconButton(
                onPressed: logincontroller.togglePasswordVisibility,
                icon: Icon(
                  logincontroller.isObsecure
                      ? Icons.visibility_off
                      : Icons.remove_red_eye_rounded,
                  color: AppColor.appimagecolor,
                ),
              ),
            ),
            SizedBox(height: height * .03),

            // Login Button
            logincontroller.isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    onTap: () => logincontroller.login(context),
                    title: "Log In",
                    bgColor: AppColor.appimagecolor,
                    textStyle: const TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: AppFontSizes.font16,
                    ),
                    height: height * 0.07,
                    width: double.infinity,
                  ),

            SizedBox(height: height * .02),

            // Error / Success
            if (logincontroller.loginError != null)
              Text(logincontroller.loginError!,
                  style: const TextStyle(color: Colors.red)),
            if (logincontroller.response != null)
              Text(logincontroller.response!,
                  style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
