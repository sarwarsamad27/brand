import 'package:brand/barrelView/barrelView.dart';

class VerifyYourOTPScreen extends StatelessWidget {
  const VerifyYourOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verifyYourIdentityViewModel =
        Provider.of<VerifyYourIdentityViewModel>(context);
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
                      height: screenHeight * 0.03, // Dynamic height for spacing
                    ),
                    const CustomText(
                      text: 'verify Your Identity',
                      style: TextStyle(
                        fontSize: AppFontSizes.font21,
                        fontWeight: AppFontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02, // Dynamic height for spacing
                    ),
                    const CustomText(
                      text: 'enter Your Password To Verify Your Identity',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: AppFontSizes.font15,
                        fontWeight: AppFontWeight.w400,
                        color: AppColor.textSecondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02, // Dynamic height for spacing
                    ),
                    CustomTextField(
                      controller: verifyYourIdentityViewModel.passController,
                      labelText: 'password',
                      isObSecure: verifyYourIdentityViewModel.passIsObsecure,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            width: screenWidth * 0.05, // Dynamic icon size
                            height: screenWidth * 0.05, // Dynamic icon size
                            child: const Icon(Icons.lock)),
                      ),
                      suffixIcon: IconButton(
                        onPressed: verifyYourIdentityViewModel.passObsecureText,
                        icon: Image.asset(
                          verifyYourIdentityViewModel.passIsObsecure
                              ? Assets.eye
                              : Assets.hideEye,
                          height: screenWidth * 0.06, // Dynamic icon size
                          width: screenWidth * 0.06, // Dynamic icon size
                        ),
                        color: AppColor.primaryColor,
                      ),
                      borderColor: AppColor.textSecondaryColor,
                      borderRadius: AppBorderRadius.radius5,
                      txtColor: AppColor.primaryColor,
                    ),
                    SizedBox(
                      height: screenHeight * 0.04, // Dynamic height for spacing
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.updateNewPassword,
                        );
                      },
                      title: 'verify',
                      textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: AppFontSizes.font15,
                        fontWeight: AppFontWeight.w500,
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
