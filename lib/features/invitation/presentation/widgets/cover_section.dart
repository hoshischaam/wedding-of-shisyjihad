import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';

class CoverSection extends StatelessWidget {
  final VoidCallback onOpen;
  final String guestName;

  const CoverSection({Key? key, required this.onOpen, required this.guestName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>().invitationData;
    
    if (invitation == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        image: const DecorationImage(
          image: AssetImage('assets/gambar/cover_awal.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "The Wedding Of",
                style: AppStyles.bodyStyle.copyWith(
                  color: Colors.white70,
                  letterSpacing: 3,
                ),
              ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5),
              
              const SizedBox(height: 20),
              
              Text(
                "${invitation.groomName} & ${invitation.brideName}",
                style: AppStyles.coverNameStyle.copyWith(
                  color: Colors.white,
                  fontSize: 44,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms, duration: 800.ms).scale(),
              
              const SizedBox(height: 40),
              
              Text(
                "Kepada Bapak/Ibu/Saudara/i :",
                style: AppStyles.bodyStyle.copyWith(color: Colors.white70),
              ).animate().fadeIn(delay: 800.ms),
              
              const SizedBox(height: 10),
              
              Text(
                guestName,
                style: AppStyles.headingStyle.copyWith(color: Colors.white, fontSize: 32),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 1000.ms),
              
              const SizedBox(height: 40),
              
              ElevatedButton.icon(
                onPressed: onOpen,
                icon: const Icon(Icons.mail_outline),
                label: const Text("Buka Undangan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
              ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.5),
            ],
          ),
        ),
      ),
    );
  }
}
