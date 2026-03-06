import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/sounds.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  int _score = 0;
  bool _showResult = false;
  bool _quizCompleted = false;
  List<bool?> _answerResults = [];

  @override
  void initState() {
    super.initState();
    _answerResults = List.filled(AppConstants.quizQuestions.length, null);
  }

  void _checkAnswer() {
    if (_selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار إجابة'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    bool isCorrect = _selectedAnswer ==
        AppConstants.quizQuestions[_currentQuestionIndex]['answer'];

    setState(() {
      _showResult = true;
      _answerResults[_currentQuestionIndex] = isCorrect;
    });

    if (isCorrect) {
      _score++;
      SoundUtils.playCorrectSound();
    } else {
      SoundUtils.playWrongSound();
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestionIndex < AppConstants.quizQuestions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
          _showResult = false;
        });
      } else {
        setState(() {
          _quizCompleted = true;
        });
        if (_score == AppConstants.quizQuestions.length) {
          SoundUtils.playCheerSound();
        }
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswer = null;
      _score = 0;
      _showResult = false;
      _quizCompleted = false;
      _answerResults = List.filled(AppConstants.quizQuestions.length, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اختبر معرفتك بالأردن',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppConstants.jordanianRed,
                AppConstants.jordanianGreen,
                AppConstants.jordanianBlack,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: _quizCompleted ? _buildResultScreen() : _buildQuizScreen(),
      ),
    );
  }

  Widget _buildQuizScreen() {
    final question = AppConstants.quizQuestions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // مؤشر التقدم مع ألوان العلم
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          AppConstants.jordanianRed,
                          AppConstants.jordanianGreen,
                          AppConstants.jordanianBlack,
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor:
                        (_currentQuestionIndex + 1) / AppConstants.quizQuestions.length,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            AppConstants.jordanianRed,
                            AppConstants.jordanianGreen,
                            AppConstants.jordanianBlack,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السؤال ${_currentQuestionIndex + 1}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.jordanianRed,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppConstants.jordanianGreen,
                          AppConstants.jordanianBlack,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_score/${AppConstants.quizQuestions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // السؤال
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: AppConstants.jordanianRed.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Text(
              question['question'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.jordanianBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 30),

          // الخيارات
          Expanded(
            child: ListView.builder(
              itemCount: question['options'].length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedAnswer == index;
                bool isCorrect =
                    _showResult && index == question['answer'];
                bool isWrong = _showResult && isSelected && !isCorrect;

                Color? buttonColor;
                if (isCorrect) {
                  buttonColor = AppConstants.jordanianGreen;
                } else if (isWrong) {
                  buttonColor = AppConstants.jordanianRed;
                } else if (isSelected) {
                  buttonColor = Colors.blue;
                } else {
                  buttonColor = Colors.white;
                }

                Color textColor = buttonColor == Colors.white
                    ? AppConstants.jordanianBlack
                    : Colors.white;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: _showResult
                        ? null
                        : () {
                            setState(() {
                              _selectedAnswer = index;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: textColor,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected && !_showResult
                              ? AppConstants.jordanianRed
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      elevation: isSelected ? 8 : 2,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Colors.white.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index), // A, B, C, D
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected && !_showResult
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            question['options'][index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        if (_showResult && isCorrect)
                          const Icon(Icons.check_circle,
                              color: Colors.white),
                        if (_showResult && isWrong)
                          const Icon(Icons.cancel, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // زر الإجابة
          if (!_showResult)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.jordanianGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'تحقق من الإجابة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          if (_showResult)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _selectedAnswer == question['answer']
                    ? AppConstants.jordanianGreen.withOpacity(0.1)
                    : AppConstants.jordanianRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedAnswer == question['answer']
                      ? AppConstants.jordanianGreen
                      : AppConstants.jordanianRed,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedAnswer == question['answer']
                        ? Icons.check_circle
                        : Icons.info,
                    color: _selectedAnswer == question['answer']
                        ? AppConstants.jordanianGreen
                        : AppConstants.jordanianRed,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _selectedAnswer == question['answer']
                          ? 'إجابة صحيحة! أحسنت'
                          : 'الإجابة الصحيحة هي: ${question['options'][question['answer']]}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    double percentage = (_score / AppConstants.quizQuestions.length) * 100;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // نتيجة بصورة العلم
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppConstants.jordanianRed,
                    AppConstants.jordanianGreen,
                    AppConstants.jordanianBlack,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '$_score',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'من ${AppConstants.quizQuestions.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              percentage >= 70 ? 'ممتاز! 🎉' : 'حاول مرة أخرى 💪',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: percentage >= 70
                    ? AppConstants.jordanianGreen
                    : AppConstants.jordanianRed,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'لقد حصلت على $_score من ${AppConstants.quizQuestions.length} إجابات صحيحة',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // عرض الإجابات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'نتائج الأسئلة:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(_answerResults.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _answerResults[index] == true
                            ? AppConstants.jordanianGreen.withOpacity(0.1)
                            : AppConstants.jordanianRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _answerResults[index] == true
                              ? AppConstants.jordanianGreen
                              : AppConstants.jordanianRed,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _answerResults[index] == true
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: _answerResults[index] == true
                                ? AppConstants.jordanianGreen
                                : AppConstants.jordanianRed,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'سؤال ${index + 1}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _restartQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.jordanianGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('إعادة الاختبار'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.jordanianRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('العودة'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}