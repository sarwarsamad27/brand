// ignore_for_file: unused_local_variable

import 'package:brand/barrelView/barrelView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await CacheHelper.init();
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

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final initialRoute = (snapshot.data != null)
            ? RoutesName.userloginScreen
            : RoutesName.userloginScreen;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeManager.themeMode,
          color: AppColor.screenBgColor,
          routes: AppPages.getRoutes(),
          initialRoute: initialRoute,
        );
      },
    );
  }
}
