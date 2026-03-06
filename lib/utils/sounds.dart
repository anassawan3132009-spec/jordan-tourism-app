import 'package:audioplayers/audioplayers.dart';

class SoundUtils {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // صوت تصفيق للتقييم العالي
  static Future<void> playClapSound() async {
    try {
      // إذا كان لديك ملف صوتي ضعه في assets/audio/clap.mp3
      // await _audioPlayer.play(AssetSource('audio/clap.mp3'));
      print('👏 تصفيق');
    } catch (e) {
      print('خطأ في تشغيل صوت التصفيق: $e');
    }
  }

  // صوت تشجيع للإجابات الصحيحة
  static Future<void> playCheerSound() async {
    try {
      // إذا كان لديك ملف صوتي ضعه في assets/audio/cheer.mp3
      // await _audioPlayer.play(AssetSource('audio/cheer.mp3'));
      print('🎉 تشجيع');
    } catch (e) {
      print('خطأ في تشغيل صوت التشجيع: $e');
    }
  }

  // صوت إجابة صحيحة
  static Future<void> playCorrectSound() async {
    try {
      // إذا كان لديك ملف صوتي ضعه في assets/audio/correct.mp3
      // await _audioPlayer.play(AssetSource('audio/correct.mp3'));
      print('✅ إجابة صحيحة');
    } catch (e) {
      print('خطأ في تشغيل صوت الإجابة الصحيحة: $e');
    }
  }

  // صوت خطأ
  static Future<void> playWrongSound() async {
    try {
      print('❌ إجابة خاطئة');
    } catch (e) {
      print('خطأ في تشغيل الصوت: $e');
    }
  }

  static void dispose() {
    _audioPlayer.dispose();
  }
}