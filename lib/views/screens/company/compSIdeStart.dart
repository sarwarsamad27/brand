import 'package:brand/barrelView/barrelView.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ComSideStartScreen extends StatefulWidget {
  const ComSideStartScreen({super.key});

  @override
  State<ComSideStartScreen> createState() => _ComSideStartScreenState();
}

class _ComSideStartScreenState extends State<ComSideStartScreen> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    _speak();
    _navigateBasedOnFormStatus();
  }

  Future<void> _navigateBasedOnFormStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFormSubmitted = prefs.getBool('isFormSubmitted') ?? false;

    Future.delayed(const Duration(seconds: 4), () {
      if (isFormSubmitted) {
        Navigator.pushReplacementNamed(context, RoutesName.compHomeScreen);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.comFormScreen);
      }
    });
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts
        .setVoice({"name": "en-us-x-sfg#female", "locale": "en-US"});
    await flutterTts.speak(
        "Welcome to Brand Application. Here you can build your business.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              "Welcome to Brand Application...",
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TyperAnimatedText(
              "Here you can build your business...",
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
          isRepeatingAnimation: false,
        ),
      ),
    );
  }
}
