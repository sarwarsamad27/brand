import '../../../barrelView/barrelView.dart';

class InitializeProvider {
  static List<SingleChildWidget> createChangeNotifierProvider = [
    ChangeNotifierProvider(create: (_) => LoginController()),
    ChangeNotifierProvider(create: (_) => Signincontroller()),
    ChangeNotifierProvider(create: (_) => ForgotController()),
    ChangeNotifierProvider(create: (_) => VerifyYourIdentityViewModel()),
    ChangeNotifierProvider(create: (_) => CreateNewPasswordViewModel()),
    ChangeNotifierProvider(create: (_) => Orderformcontroller()),
    ChangeNotifierProvider(create: (_) => Profilescreencontroller()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
    ChangeNotifierProvider(create: (_) => LogoutRepository()),
    ChangeNotifierProvider(create: (_) => HomescreenController()),
    ChangeNotifierProvider(create: (_) => Onboardcontroller()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => ProductDetailController()),
    ChangeNotifierProvider(create: (_) => ExploreScreenController()),
    ChangeNotifierProvider(create: (_) => ThemeManager()),
    ChangeNotifierProvider(create: (_) => OrderController()),
    ChangeNotifierProvider(create: (_) => ProductController()),
    ChangeNotifierProvider(create: (_) => DashboardController()),
    ChangeNotifierProvider(create: (_) => ComHomescreenController()),
    ChangeNotifierProvider(create: (_) => SampleProductController()),
    ChangeNotifierProvider(create: (_) => ProductFormProvider()),
  ];
}
