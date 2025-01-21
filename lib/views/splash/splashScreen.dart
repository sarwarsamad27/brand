import 'package:brand/barrelView/barrelView.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4),
        () => Navigator.pushNamed(context, RoutesName.onBoardScreen));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return SizedBox(
      width: 250.0,
      child: TextLiquidFill(
        text: 'Brands',
        waveColor: Colors.blueAccent,
        boxBackgroundColor: AppColor.primaryColor,
        textStyle: const TextStyle(
          color: AppColor.textPrimaryColor,
          fontSize: 80.0,
          fontWeight: FontWeight.bold,
        ),
        boxHeight: height * 1,
        boxWidth: width * 1,
      ),
    );
  }
}
