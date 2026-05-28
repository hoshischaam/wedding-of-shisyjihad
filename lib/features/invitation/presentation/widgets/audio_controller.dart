import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../core/app_colors.dart';

class AudioControllerWidget extends StatefulWidget {
  const AudioControllerWidget({super.key});

  @override
  State<AudioControllerWidget> createState() => _AudioControllerWidgetState();
}

class _AudioControllerWidgetState extends State<AudioControllerWidget>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);

    // Auto-play saat widget pertama kali muncul
    _startAudio();
  }

  Future<void> _startAudio() async {
    try {
      await _audioPlayer.play(AssetSource('audio/background_music.mp3'));
      if (mounted) {
        setState(() => _isPlaying = true);
        _rotationController.repeat();
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _rotationController.stop();
    } else {
      await _audioPlayer.resume();
      _rotationController.repeat();
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: GestureDetector(
        onTap: _togglePlay,
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 2 * 3.14159,
              child: child,
            );
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isPlaying ? Icons.music_note : Icons.music_off,
                key: ValueKey(_isPlaying),
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
