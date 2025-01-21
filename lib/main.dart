import 'package:brand/barrelView/barrelView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // ignore: unused_local_variable
  Widget widget;
  String? token;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const Homescreen();
    } else {
      widget = Onboardscreen();
    }
  } else {
    widget = Onboardscreen();
  }

  runApp(
    MultiProvider(
      providers: InitializeProvider.createChangeNotifierProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading screen while waiting for the token check
          return const Center(child: CircularProgressIndicator());
        }

        // If a token is found, set the home screen as the initial route
        final initialRoute = (snapshot.data != null)
            ? RoutesName.compHomeScreen
            : RoutesName.compHomeScreen;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light(), // Light theme
          darkTheme: ThemeData.dark(), // Dark theme
          themeMode:
              themeManager.themeMode, // Dynamic theme based on user preference
          color: AppColor.screenBgColor,
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
          routes: AppPages.getRoutes(),
          initialRoute: initialRoute,
        );
      },
    );
  }
}
