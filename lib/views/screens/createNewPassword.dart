import 'package:brand/barrelView/barrelView.dart';

class UpdateNewPassword extends StatelessWidget {
  const UpdateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final createNewPassRepo = Provider.of<CreateNewPasswordViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context); // Get screen size
    final isMobile =
        screenSize.width < 600; // Check if it's mobile based on width
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Dynamic horizontal and vertical padding based on screen width and height
    double horizontalPadding = screenWidth *
        (isMobile
            ? 0.05
            : 0.1); // 5% padding for mobile, 10% for larger screens
    double verticalPadding = screenHeight * 0.02; // 2% vertical padding
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, // Dynamic horizontal padding
                  vertical: verticalPadding, // Dynamic vertical padding
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.03, // Dynamic height
                    ),
                    const CustomText(
                      text: 'create New Password',
                      style: TextStyle(
                        fontSize: AppFontSizes.font21,
                        fontWeight: AppFontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02, // Dynamic spacing
                    ),
                    const CustomText(
                      text:
                          'your New Password Must Be Different From Previous UsedPassword',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: AppFontSizes.font15,
                        fontWeight: AppFontWeight.w400,
                        color: AppColor.textPrimaryLightColor,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02, // Dynamic spacing
                    ),
                    CustomTextField(
                      controller: createNewPassRepo.passwordController,
                      labelText: 'password',
                      isObSecure: createNewPassRepo.passIsObsecure,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            width: screenWidth * 0.05, // Dynamic icon size
                            height: screenWidth * 0.05, // Dynamic icon size
                            child: const Icon(Icons.lock)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: createNewPassRepo.passObsecureText,
                        icon: Image.asset(
                          createNewPassRepo.passIsObsecure
                              ? Assets.eye
                              : Assets.hideEye,
                          height: screenWidth * 0.05, // Dynamic icon size
                          width: screenWidth * 0.05, // Dynamic icon size
                        ),
                        color: AppColor.primaryColor,
                      ),
                      borderColor: AppColor.textSecondaryColor,
                      borderRadius: AppBorderRadius.radius5,
                      txtColor: AppColor.primaryColor,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02, // Dynamic spacing
                    ),
                    CustomTextField(
                      controller: createNewPassRepo.confirmPasswordController,
                      labelText: 'confirm Password',
                      isObSecure: createNewPassRepo.confirmPassIsObsecure,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            width: screenWidth * 0.05, // Dynamic icon size
                            height: screenWidth * 0.05, // Dynamic icon size
                            child: const Icon(Icons.lock)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: createNewPassRepo.confirmPassObsecure,
                        icon: Image.asset(
                          createNewPassRepo.confirmPassIsObsecure
                              ? Assets.eye
                              : Assets.hideEye,
                          width: screenWidth * 0.05, // Dynamic icon size
                          height: screenWidth * 0.05, // Dynamic icon size
                        ),
                        color: AppColor.primaryColor,
                      ),
                      borderColor: AppColor.textSecondaryColor,
                      borderRadius: AppBorderRadius.radius5,
                      txtColor: AppColor.primaryColor,
                    ),
                    SizedBox(
                      height: screenHeight * 0.03, // Dynamic spacing
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.loginScreen,
                        );
                      },
                      title: 'update',
                      textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: AppFontSizes.font16,
                        fontWeight: AppFontWeight.w600,
                      ),
                      bgColor: AppColor.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
