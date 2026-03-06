import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/constants.dart';
import '../utils/sounds.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 3.0;
  bool _isSubmitted = false;
  final TextEditingController _feedbackController = TextEditingController();

  final List<Map<String, dynamic>> _ratingMessages = [
    {'emoji': '😞', 'message': 'نأسف لتجربتك، سنحسن التطبيق'},
    {'emoji': '😐', 'message': 'شكراً لملاحظاتك'},
    {'emoji': '🙂', 'message': 'نقدر رأيك'},
    {'emoji': '😊', 'message': 'سعداء بتجربتك!'},
    {'emoji': '🥰', 'message': 'نحبك! شكراً جزيلاً'},
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitRating() {
    setState(() {
      _isSubmitted = true;
    });

    if (_rating >= 4.0) {
      SoundUtils.playClapSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تقييم التطبيق',
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
              AppConstants.jordanianRed.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: _isSubmitted ? _buildThankYou() : _buildRatingForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingForm() {
    int ratingIndex = _rating.round() - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // أيقونة العلم
        Container(
          width: 100,
          height: 100,
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
          child: const Center(
            child: Icon(
              Icons.star,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'شاركنا رأيك',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppConstants.jordanianRed,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'تقييمك يساعدنا على تحسين التطبيق',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),

        const SizedBox(height: 40),

        // التقييم بالنجوم
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),

              const SizedBox(height: 20),

              // رسالة حسب التقييم
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.jordanianRed.withOpacity(0.1),
                      AppConstants.jordanianGreen.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _ratingMessages[ratingIndex]['emoji'],
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_rating.toStringAsFixed(1)} من 5',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _ratingMessages[ratingIndex]['message'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // حقل الملاحظات
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: AppConstants.jordanianRed,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'أضف ملاحظاتك (اختياري)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اكتب رأيك هنا... كيف كانت تجربتك مع التطبيق؟',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // زر الإرسال
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: _submitRating,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.jordanianGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: const Text(
              'إرسال التقييم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThankYou() {
    int ratingIndex = _rating.round() - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // أيقونة النجاح
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppConstants.jordanianRed,
                AppConstants.jordanianGreen,
              ],
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
          child: const Center(
            child: Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'شكراً لتقييمك!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppConstants.jordanianRed,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'نقدر لك وقتك ومشاركتنا رأيك',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),

        const SizedBox(height: 30),

        // ملخص التقييم
        Container(
          padding: const EdgeInsets.all(20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < _rating.round()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  );
                }),
              ),
              const SizedBox(height: 12),
              Text(
                '${_ratingMessages[ratingIndex]['emoji']} ${_ratingMessages[ratingIndex]['message']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_feedbackController.text.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '"${_feedbackController.text}"',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 30),

        // زر العودة
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.jordanianRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'العودة للرئيسية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}