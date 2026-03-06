import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'أكتشف سحر الأردن';
  
  // ألوان العلم الأردني 🇯🇴
  static const Color jordanianRed = Color(0xFFCE1126);
  static const Color jordanianGreen = Color(0xFF007A3D);
  static const Color jordanianBlack = Color(0xFF000000);
  static const Color jordanianWhite = Color(0xFFFFFFFF);
  
  // ألوان التطبيق
  static const Color primaryBrown = Color(0xFF8B4513);
  static const Color secondaryBrown = Color(0xFFD2691E);
  static const Color primaryAmber = Colors.amber;
  
  // قائمة أسئلة الاختبار
  static final List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'أين تقع مدينة البتراء؟',
      'options': ['شمال الأردن', 'جنوب الأردن', 'شرق الأردن', 'غرب الأردن'],
      'answer': 1,
    },
    {
      'question': 'بماذا تشتهر منطقة وادي رم؟',
      'options': ['جبالها الحمراء', 'بحرها الميت', 'آثارها الرومانية', 'أسواقها الشعبية'],
      'answer': 0,
    },
    {
      'question': 'ما هي أخفض نقطة على سطح الأرض؟',
      'options': ['وادي رم', 'جبل نيبو', 'البحر الميت', 'العقبة'],
      'answer': 2,
    },
    {
      'question': 'بماذا كان يسمى الأردن قديماً؟',
      'options': ['بلاد الرافدين', 'بلاد الشام', 'مملكة الأنباط', 'مملكة أدوم'],
      'answer': 2,
    },
    {
      'question': 'ما هو المعلم الشهير في مدينة جرش؟',
      'options': ['الخزنة', 'المدرج الروماني', 'الدير', 'جسر الملك حسين'],
      'answer': 1,
    },
  ];
}