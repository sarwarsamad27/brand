import 'package:brand/resources/global.dart';
import 'package:brand/view_model/Controller/companySideController/comEntryProductShowController.dart';
import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';
import 'package:brand/view_model/Controller/companySideController/comProfileController.dart';
import 'package:brand/view_model/Controller/companySideController/comloginController.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/view_model/Controller/loginController/signInCompanyController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/exploreScreenController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/favouriteProductController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/homeScreenController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/myOrderController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productDetailController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productEntryController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productShowController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/searchScreenController.dart';

import '../../../barrelView/barrelView.dart';

class InitializeProvider {
  static List<SingleChildWidget> createChangeNotifierProvider = [
    ChangeNotifierProvider(create: (_) => UserLoginController()),
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
    ChangeNotifierProvider(create: (_) => CreateOrderController()),
    ChangeNotifierProvider(create: (_) => ProductEntryController()),
    ChangeNotifierProvider(create: (_) => DashboardController()),
    ChangeNotifierProvider(
        create: (_) => ComHomescreenController(
              userId: Global.loggedInCompanyId ?? '',
            )),
    ChangeNotifierProvider(create: (_) => ProductEntryController()),
    ChangeNotifierProvider(create: (_) => CreateProductController()),
    ChangeNotifierProvider(create: (_) => CompanyFormController()),
    ChangeNotifierProvider(create: (_) => SigninCompanyController()),
    ChangeNotifierProvider(create: (_) => ComProductDetailController()),
    ChangeNotifierProvider(create: (_) => CompLoginController()),
    ChangeNotifierProvider(create: (_) => ExploreScreenController()),
    ChangeNotifierProvider(create: (_) => ProductDetailController()),
    ChangeNotifierProvider(create: (_) => ProductShowController()),
    ChangeNotifierProvider(create: (_) => ComEntryProductShowController()),
    ChangeNotifierProvider(create: (_) => FavouriteController()),
    ChangeNotifierProvider(create: (_) => SearchProductController()),
    ChangeNotifierProvider(create: (_) => MyOrdersController()),
    ChangeNotifierProvider(create: (_) => ComProfileController()),
  ];
}
