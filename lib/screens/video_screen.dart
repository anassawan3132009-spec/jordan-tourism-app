import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/constants.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    // ✅ استخدم المسار الصحيح للفيديو داخل مجلد assets
    _controller = VideoPlayerController.asset('assets/videos/jordan.mp4');

    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller.addListener(() {
          if (mounted) {
            setState(() {
              _isPlaying = _controller.value.isPlaying;
            });
          }
        });
      }
    } catch (e) {
      print('خطأ في تحميل الفيديو: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // الفيديو
          if (_isInitialized)
            GestureDetector(
              onTap: _toggleControls,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // طبقة مظلمة عند ظهور التحكم
          if (_showControls)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

          // أزرار التحكم
          if (_showControls) ...[
            // زر العودة
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // عنوان الفيديو
            Positioned(
              top: 50,
              right: 20,
              left: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'اكتشف جمال الأردن',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Discover Jordan',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // زر التشغيل المركزي
            if (!_isPlaying)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
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
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _togglePlayPause,
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),

            // أزرار التحكم السفلية
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // شريط التقدم
                  if (_isInitialized)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            _formatDuration(_controller.value.position),
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                  playedColor: AppConstants.jordanianRed,
                                  bufferedColor: Colors.white38,
                                  backgroundColor: Colors.white12,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _formatDuration(_controller.value.duration),
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // أزرار التحكم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(
                        icon: Icons.replay_10,
                        onPressed: () {
                          final position = _controller.value.position;
                          _controller.seekTo(position - const Duration(seconds: 10));
                        },
                      ),
                      _buildControlButton(
                        icon: Icons.fast_rewind,
                        onPressed: () {
                          _controller.seekTo(Duration.zero);
                        },
                      ),
                      Container(
                        width: 60,
                        height: 60,
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
                              color: Colors.amber.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _togglePlayPause,
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      _buildControlButton(
                        icon: Icons.forward_10,
                        onPressed: () {
                          final position = _controller.value.position;
                          _controller.seekTo(position + const Duration(seconds: 10));
                        },
                      ),
                      _buildControlButton(
                        icon: Icons.replay,
                        onPressed: () {
                          _controller.seekTo(Duration.zero);
                          _controller.play();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}