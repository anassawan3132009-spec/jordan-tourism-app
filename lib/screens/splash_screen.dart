import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCE1126), // أحمر العلم
              Color(0xFF007A3D), // أخضر العلم
              Color(0xFF000000), // أسود العلم
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // العلم الأردني الصحيح
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Stack(
                      children: [
                        // الأشرطة الأفقية: أسود - أبيض - أخضر
                        Column(
                          children: [
                            Expanded(
                              child: Container(color: Colors.black), // أسود
                            ),
                            Expanded(
                              child: Container(color: Colors.white), // أبيض
                            ),
                            Expanded(
                              child: Container(color: Colors.green), // أخضر
                            ),
                          ],
                        ),
                        // المثلث الأحمر على اليسار
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: ClipPath(
                            clipper: TriangleClipper(),
                            child: Container(
                              width: 80,
                              color: Colors.red, // أحمر
                            ),
                          ),
                        ),
                        // النجمة السباعية البيضاء داخل المثلث
                        const Positioned(
                          left: 25,
                          top: 90,
                          child: Text(
                            '✷',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // النص الرئيسي
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'اكتشف سحر الأردن',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Experience Jordan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // مؤشر التحميل
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Column(
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'جاري تحميل التطبيق...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// كلاس لقص المثلث
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);           // يبدأ من الزاوية اليسرى العليا
    path.lineTo(size.width, 0);   // يذهب إلى الزاوية اليمنى العليا
    path.lineTo(0, size.height);  // يذهب إلى الزاوية اليسرى السفلى
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}