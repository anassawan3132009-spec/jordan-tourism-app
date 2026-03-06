import 'package:flutter/material.dart';
import 'video_screen.dart';
import 'attractions_list_screen.dart';
import 'quiz_screen.dart';
import 'rating_screen.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('أكتشف سحر الأردن'),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '🇯🇴',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppConstants.jordanianRed,
                AppConstants.jordanianGreen,
                AppConstants.jordanianBlack,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amber.shade50,
              Colors.orange.shade50,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      '🇯🇴',
                      style: TextStyle(fontSize: 80),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'مرحباً بكم في الأردن',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'اكتشف سحر الطبيعة والتاريخ والثقافة',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 40),
                _buildHomeButton(
                  context,
                  'فيديو تعريفي',
                  Icons.play_circle_fill,
                  AppConstants.jordanianRed,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoScreen()),
                  ),
                ),
                _buildHomeButton(
                  context,
                  'المعالم السياحية',
                  Icons.location_on,
                  AppConstants.jordanianGreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AttractionsListScreen()),
                  ),
                ),
                _buildHomeButton(
                  context,
                  'اختبار المعرفة',
                  Icons.quiz,
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  ),
                ),
                _buildHomeButton(
                  context,
                  'تقييم التطبيق',
                  Icons.star,
                  Colors.amber,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RatingScreen()),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '© 2026 هيئة السياحة الأردنية',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}