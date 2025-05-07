import 'package:fitnova/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnova/presentation/screens/home_screen.dart';
import 'package:fitnova/presentation/widgets/splash_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    print('SplashScreen: initState called');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
    _navigateToHome();
  }

  @override
  void dispose() {
    print('SplashScreen: dispose called');
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToHome() async {
    print('SplashScreen: _navigateToHome called');
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) {
      print('SplashScreen: Widget not mounted, skipping navigation');
      return;
    }
    print('SplashScreen: Navigating to MainScreen');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('SplashScreen: build called');
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    return Scaffold(
      body: SplashBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SplashLogo(),
                    SizedBox(height: size.height * 0.01),
                    const SplashAppName(),
                    SizedBox(height: size.height * 0.015),
                    const SplashTagline(),
                    SizedBox(height: size.height * 0.06),
                    SplashLoadingBar(progressAnimation: _progressAnimation),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 