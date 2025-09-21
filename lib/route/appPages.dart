import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/screens/company/comLoginScreen.dart';
import 'package:brand/views/screens/company/compSIdeStart.dart';
import 'package:brand/views/screens/company/profileScreen/comFormScreen.dart';
import 'package:brand/views/screens/company/signInCompanyScreen.dart';
import 'package:brand/views/screens/user/userFormScreen.dart';

class AppPages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RoutesName.splashScreen: (context) => const Splashscreen(),
      RoutesName.homeScreen: (context) => const Homescreen(),
      RoutesName.userloginScreen: (context) => const UserLoginscreen(),
      RoutesName.usersignInScreen: (context) => const SignInUserScreen(),
      RoutesName.forgotScreen: (context) => const ForgotScreen(),
      RoutesName.verifyYourOTPScreen: (context) => const VerifyYourOTPScreen(),
      RoutesName.updateNewPassword: (context) => const UpdateNewPassword(),
      // RoutesName.productScreen: (context) => Productscreen(),
      RoutesName.paymentScreen: (context) => const PaymentScreen(),
      RoutesName.messageScreen: (context) => const MessageScreen(),
      RoutesName.termAndConditionScreen: (context) =>
          const Termandconditionscreen(),
      RoutesName.searchScreen: (context) => const Searchscreen(),
      RoutesName.exploreScreen: (context) => ExploreScreen(),
      RoutesName.onBoardScreen: (context) => Onboardscreen(),
      RoutesName.comFormScreen: (context) => ComFormScreen(),
      RoutesName.compHomeScreen: (context) => const CompanyHomeScreen(),
      RoutesName.comSideStartScreen: (context) => const ComSideStartScreen(),
      RoutesName.signinCompanyScreen: (context) => const SigninCompanyScreen(),
      RoutesName.comLogInScreen: (context) => const ComLoginScreen(),
      RoutesName.userFormScreen: (context) => const UserFormScreen(),
    };
  }
}
