import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';
import 'package:brand/view_model/Controller/companySideController/comloginController.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/view_model/Controller/loginController/signInCompanyController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/exploreScreenController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/homeScreenController.dart';
import 'package:brand/views/screens/company/profileScreen/comProfileScreen.dart';

import '../../../barrelView/barrelView.dart';

class InitializeProvider {
  static List<SingleChildWidget> createChangeNotifierProvider = [
    ChangeNotifierProvider(create: (_) => LoginController()),
    ChangeNotifierProvider(create: (_) => SignUpUsercontroller()),
    ChangeNotifierProvider(create: (_) => ForgotController()),
    ChangeNotifierProvider(create: (_) => VerifyYourIdentityViewModel()),
    ChangeNotifierProvider(create: (_) => CreateNewPasswordViewModel()),
    ChangeNotifierProvider(create: (_) => Orderformcontroller()),
    ChangeNotifierProvider(create: (_) => ProfileScreenController()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
    ChangeNotifierProvider(create: (_) => LogoutRepository()),
    ChangeNotifierProvider(create: (_) => HomescreenController()),
    ChangeNotifierProvider(create: (_) => Onboardcontroller()),
    ChangeNotifierProvider(create: (_) => ThemeManager()),
    ChangeNotifierProvider(create: (_) => OrderController()),
    ChangeNotifierProvider(create: (_) => ProductController()),
    ChangeNotifierProvider(create: (_) => DashboardController()),
    ChangeNotifierProvider(create: (_) => ComHomescreenController()),
    ChangeNotifierProvider(create: (_) => SampleProductController()),
    ChangeNotifierProvider(create: (_) => ProductFormProvider()),
    ChangeNotifierProvider(create: (_) => CompanyFormController()),
    ChangeNotifierProvider(create: (_) => SigninCompanyController()),
    ChangeNotifierProvider(create: (_) => ComProductDetailController()),
    ChangeNotifierProvider(create: (_) => CompLoginController()),
    ChangeNotifierProvider(create: (_) => ExploreScreenController()),
  ];
}
