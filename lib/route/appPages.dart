import 'package:brand/barrelView/barrelView.dart';

class AppPages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RoutesName.splashScreen: (context) => const Splashscreen(),
      RoutesName.homeScreen: (context) => const Homescreen(),
      RoutesName.loginScreen: (context) => const Loginscreen(),
      RoutesName.signInScreen: (context) => const SignInScreen(),
      RoutesName.forgotScreen: (context) => const ForgotScreen(),
      RoutesName.verifyYourOTPScreen: (context) => const VerifyYourOTPScreen(),
      RoutesName.updateNewPassword: (context) => const UpdateNewPassword(),
      RoutesName.productScreen: (context) => Productscreen(),
      RoutesName.paymentScreen: (context) => PaymentScreen(),
      RoutesName.messageScreen: (context) => const MessageScreen(),
      RoutesName.termAndConditionScreen: (context) =>
          const Termandconditionscreen(),
      RoutesName.searchScreen: (context) => const Searchscreen(),
      RoutesName.exploreScreen: (context) => const Explorescreen(),
      RoutesName.onBoardScreen: (context) => Onboardscreen(),
      RoutesName.selectedProductScreen: (context) => SelectedProductScreen(),
      RoutesName.compHomeScreen: (context) => CompanyHomeScreen(),
    };
  }
}
