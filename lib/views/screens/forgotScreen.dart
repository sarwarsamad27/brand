import 'package:brand/barrelView/barrelView.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotController = Provider.of<ForgotController>(context);
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
    double verticalPadding =
        screenHeight * 0.02; // 2% of the height as vertical padding

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.appbackgroundcolor,
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
                      height: screenHeight *
                          0.05, // 5% of screen height for spacing
                    ),
                    const CustomText(
                      text: 'forgot Password',
                      style: TextStyle(
                        fontSize: AppFontSizes.font21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight *
                          0.03, // 3% of screen height for spacing
                    ),
                    const CustomText(
                      text:
                          'please Confirm Email Address We Will Send You Link To Verify Your Identity',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: AppFontSizes.font16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textSecondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight *
                          0.03, // 3% of screen height for spacing
                    ),
                    CustomTextField(
                      controller: forgotController.forgotController,
                      labelText: 'email',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SizedBox(
                            width: screenWidth *
                                0.05, // 5% of screen width for icon size
                            height: screenWidth *
                                0.05, // 5% of screen width for icon size
                            child: const Icon(
                              Icons.message_outlined,
                              color: AppColor.appimagecolor,
                            )),
                      ),
                      borderColor: AppColor.textSecondaryColor,
                      txtColor: AppColor.primaryColor,
                      fillColor: AppColor.primaryColor,
                      borderRadius: AppBorderRadius.radius5,
                    ),
                    SizedBox(
                      height: screenHeight *
                          0.04, // 4% of screen height for spacing
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.verifyYourOTPScreen,
                        );
                      },
                      title: "send",
                      textStyle: const TextStyle(
                        color: AppColor.textWhiteColor,
                        fontSize: AppFontSizes.font16,
                        fontWeight: FontWeight.w600,
                      ),
                      bgColor: AppColor.appimagecolor,
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
