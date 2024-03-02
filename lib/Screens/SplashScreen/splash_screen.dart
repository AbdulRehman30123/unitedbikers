import 'package:unitedbiker/Packages/packages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      screenFunctions.nextScreen(context, const Navigation());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
