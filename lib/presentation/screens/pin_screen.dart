import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';
import 'package:fitnova/presentation/screens/main_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  
  static const String correctPin = "1997";
  String enteredPin = "";
  bool isError = false;
  bool isSuccess = false;

  // Animation controllers
  late AnimationController _shakeController;
  late AnimationController _successController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _floatingController;
  
  // Animations
  late Animation<double> _shakeAnimation;
  late Animation<double> _successScaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _successController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Setup animations
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticOut),
    );
    
    _successScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _successController, curve: Curves.elasticOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _floatingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _pulseController.repeat(reverse: true);
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _successController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _floatingController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(String value, int index) {
    if (value.length == 1) {
      enteredPin += value;
      
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _validatePin();
      }
    } else if (value.isEmpty && index > 0) {
      if (enteredPin.isNotEmpty) {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _validatePin() {
    if (enteredPin == correctPin) {
      setState(() {
        isError = false;
        isSuccess = true;
      });
      _successController.forward();
      Future.delayed(const Duration(milliseconds: 1000), () {
        _navigateToMain();
      });
    } else {
      setState(() {
        isError = true;
        enteredPin = "";
      });
      _shakeController.forward();
      _clearControllers();
      _focusNodes[0].requestFocus();
      
      // Reset shake animation
      Future.delayed(const Duration(milliseconds: 500), () {
        _shakeController.reset();
      });
    }
  }

  void _clearControllers() {
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  void _navigateToMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    
    return Scaffold(
      body: Container(
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
            // Animated background grid
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
            
            // Floating particles
            ...List.generate(15, (index) => _buildFloatingParticle(index)),
            
            // Main content
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated logo with glow effect
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: isSmallScreen ? 100 : 120,
                                height: isSmallScreen ? 100 : 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      blurRadius: 30,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.2),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    size: isSmallScreen ? 60 : 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).animate().scale(duration: 1000.ms, curve: Curves.easeOutBack),
                        
                        SizedBox(height: isSmallScreen ? 25 : 30),
                        
                        // Title with shadow
                        Text(
                          'FitNova',
                          style: GoogleFonts.raleway(
                            fontSize: isSmallScreen ? 32 : 36,
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
                        ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
                        
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        Text(
                          'Enter your PIN to continue',
                          style: GoogleFonts.poppins(
                            fontSize: isSmallScreen ? 14 : 16,
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
                        ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
                        
                        SizedBox(height: isSmallScreen ? 40 : 50),
                        
                        // PIN Input Fields with glass effect
                        AnimatedBuilder(
                          animation: _shakeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                isError ? _shakeAnimation.value * 15 * (1 - _shakeAnimation.value) : 0,
                                0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(4, (index) {
                                  return Container(
                                    width: isSmallScreen ? 60 : 70,
                                    height: isSmallScreen ? 60 : 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isError 
                                          ? Colors.red.withOpacity(0.8)
                                          : Colors.white.withOpacity(0.3),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isError 
                                            ? Colors.red.withOpacity(0.3)
                                            : Colors.white.withOpacity(0.2),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: BackdropFilter(
                                        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(14),
                                          ),
                                          child: TextField(
                                            controller: _controllers[index],
                                            focusNode: _focusNodes[index],
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(1),
                                            ],
                                            style: GoogleFonts.poppins(
                                              fontSize: isSmallScreen ? 22 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            onChanged: (value) => _onPinChanged(value, index),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                        ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
                        
                        if (isError) ...[
                          SizedBox(height: isSmallScreen ? 20 : 25),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 20 : 25,
                              vertical: isSmallScreen ? 12 : 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: isSmallScreen ? 20 : 24,
                                ),
                                SizedBox(width: isSmallScreen ? 8 : 10),
                                Flexible(
                                  child: Text(
                                    'Incorrect PIN. Please try again.',
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: isSmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0),
                        ],
                        
                        if (isSuccess) ...[
                          SizedBox(height: isSmallScreen ? 20 : 25),
                          AnimatedBuilder(
                            animation: _successScaleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _successScaleAnimation.value,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 20 : 25,
                                    vertical: isSmallScreen ? 12 : 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.green.withOpacity(0.5),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.2),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: isSmallScreen ? 20 : 24,
                                      ),
                                      SizedBox(width: isSmallScreen ? 8 : 10),
                                      Text(
                                        'PIN Correct!',
                                        style: GoogleFonts.poppins(
                                          color: Colors.green,
                                          fontSize: isSmallScreen ? 14 : 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        
                        const Spacer(),
                        
                        // Forgot PIN button with glass effect
                        // Container(
                        //   width: double.infinity,
                        //   height: isSmallScreen ? 50 : 55,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.15),
                        //     borderRadius: BorderRadius.circular(15),
                        //     border: Border.all(
                        //       color: Colors.white.withOpacity(0.3),
                        //       width: 1,
                        //     ),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.white.withOpacity(0.1),
                        //         blurRadius: 15,
                        //         spreadRadius: 2,
                        //       ),
                        //     ],
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(14),
                        //     child: BackdropFilter(
                        //       filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        //       child: Material(
                        //         color: Colors.transparent,
                        //         child: InkWell(
                        //           borderRadius: BorderRadius.circular(14),
                        //           onTap: () {
                        //             // You can add forgot PIN functionality here
                        //           },
                        //           child: Center(
                        //             child: Text(
                        //               'Forgot PIN?',
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.white,
                        //                 fontSize: isSmallScreen ? 16 : 18,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ).animate().fadeIn(delay: 1000.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        final random = math.Random(index);
        final x = random.nextDouble() * MediaQuery.of(context).size.width;
        final y = random.nextDouble() * MediaQuery.of(context).size.height;
        final opacity = random.nextDouble() * 0.4;
        final size = random.nextDouble() * 4 + 2;
        
        return Positioned(
          left: x,
          top: y + math.sin(_floatingAnimation.value * 2 * math.pi) * 20,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
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