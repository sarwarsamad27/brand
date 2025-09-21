import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/screens/company/comLoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  // SharedPreference (CacheHelper) se values nikal lo
  String? userId = CacheHelper.getData(key: 'userId');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  // Decide starting widget
  Widget startWidget;
  if (onBoarding != null) {
    if (userId != null && userId.isNotEmpty) {
      startWidget = const Homescreen(); // already logged in
    } else {
      startWidget = UserLoginscreen(); // login required
    }
  } else {
    startWidget = Onboardscreen(); // pehli dafa open
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
