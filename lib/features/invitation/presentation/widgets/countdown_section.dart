import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';

class CountdownSection extends StatefulWidget {
  const CountdownSection({Key? key}) : super(key: key);

  @override
  _CountdownSectionState createState() => _CountdownSectionState();
}

class _CountdownSectionState extends State<CountdownSection> {
  Timer? _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _initDuration();
    _startTimer();
  }

  void _initDuration() {
    final invitation = context.read<InvitationProvider>().invitationData;
    if (invitation != null) {
      setState(() {
        _duration = invitation.targetDate.difference(DateTime.now());
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final invitation = context.read<InvitationProvider>().invitationData;
      if (invitation != null && mounted) {
        setState(() {
          _duration = invitation.targetDate.difference(DateTime.now());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_duration.isNegative) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimeCard(_duration.inDays.toString(), "Hari", 0),
            _buildTimeCard((_duration.inHours % 24).toString(), "Jam", 100),
            _buildTimeCard((_duration.inMinutes % 60).toString(), "Menit", 200),
            _buildTimeCard((_duration.inSeconds % 60).toString(), "Detik", 300),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeCard(String value, String label, int delay) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: MediaQuery.of(context).size.width > 600 ? 80 : 70,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          bottom: BorderSide(color: AppColors.accent, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.padLeft(2, '0'),
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText.withOpacity(0.6),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms, duration: 800.ms).slideY(begin: 0.2);
  }
}
