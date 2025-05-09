import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fitnova/config/app_config.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(AppConfig.gradientStart),
            Color(AppConfig.gradientEnd),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Animate(
              effects: const [
                FadeEffect(duration: Duration(milliseconds: 1200)),
              ],
              child: CustomPaint(
                painter: GridPainter(
                  progress: 0.0,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoSize = size.width * 0.8;
    
    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 1000)),
        ScaleEffect(
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutBack,
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(AppConfig.accentColor).withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/splashlogo.png',
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading splash logo: $error');
            return Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.12; // 12% of screen width
    
    return Animate(
      effects: const [
        FadeEffect(delay: Duration(milliseconds: 800)),
        SlideEffect(
          begin: Offset(0, 0.3),
          end: Offset.zero,
          delay: Duration(milliseconds: 800),
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
        ),
      ],
      child: Text(
        AppConfig.appName,
        style: GoogleFonts.raleway(
          fontSize: fontSize.clamp(32, 52), // Min 32, max 52
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 2,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.05; // 6% of screen width
    
    return Animate(
      effects: const [
        FadeEffect(delay: Duration(milliseconds: 1000)),
        SlideEffect(
          begin: Offset(0, 0.3),
          end: Offset.zero,
          delay: Duration(milliseconds: 1000),
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
        ),
      ],
      child: Text(
        'Transform Your Fitness Journey',
        style: GoogleFonts.poppins(
          fontSize: fontSize.clamp(18, 24), // Min 18, max 24
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.9),
          letterSpacing: 0.8,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashLoadingBar extends StatelessWidget {
  final Animation<double> progressAnimation;

  const SplashLoadingBar({
    super.key,
    required this.progressAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final barWidth = size.width * 0.5; // 50% of screen width
    final barHeight = size.width * 0.02; // 2% of screen width
    
    return Animate(
      effects: const [
        FadeEffect(delay: Duration(milliseconds: 1000)),
      ],
      child: Container(
        width: barWidth,
        height: barHeight,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(barHeight / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: progressAnimation,
              builder: (context, child) {
                return Container(
                  width: barWidth * progressAnimation.value,
                  height: barHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white,
                        Colors.white.withOpacity(0.5),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(barHeight / 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double progress;
  final Color color;

  GridPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 1.0;

    final spacing = size.width / 10;
    final rows = (size.height / spacing).ceil();
    final cols = (size.width / spacing).ceil();

    for (var i = 0; i <= rows; i++) {
      final y = i * spacing;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    for (var i = 0; i <= cols; i++) {
      final x = i * spacing;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
} 