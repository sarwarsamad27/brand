import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/screens/company/comLoginScreen.dart';
import 'package:brand/views/screens/company/profileScreen/comFormScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  // SharedPreference (CacheHelper) se values nikal lo
  String? userId = CacheHelper.getData(key: 'userId');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  // Company side ke liye SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  bool isFormSubmitted = prefs.getBool('formSubmitted') ?? false;
  String? companyId = prefs.getString('companyId');

  // Decide starting widget
  Widget startWidget;
  if (onBoarding != null) {
    if (userId != null && userId.isNotEmpty) {
      startWidget = const UserLoginscreen(); // ✅ user already logged in
    } else if (companyId != null && companyId.isNotEmpty) {
      // ✅ Company login
      if (isFormSubmitted) {
        startWidget = const UserLoginscreen(); // form done → direct home
      } else {
        startWidget = const UserLoginscreen(); // form not filled → form screen
      }
    } else {
      startWidget = UserLoginscreen(); // login required
    }
  } else {
    startWidget = Onboardscreen(); // first time open
  }

  runApp(
    MultiProvider(
      providers: InitializeProvider.createChangeNotifierProvider,
      child: MyApp(startWidget: startWidget),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeManager.themeMode,
      color: AppColor.screenBgColor,
      routes: AppPages.getRoutes(),
      home: startWidget,
    );
  }
}
