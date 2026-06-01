import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';

class BrideGroomSection extends StatefulWidget {
  const BrideGroomSection({Key? key}) : super(key: key);

  @override
  State<BrideGroomSection> createState() => _BrideGroomSectionState();
}

class _BrideGroomSectionState extends State<BrideGroomSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>().invitationData;
    if (invitation == null) return const SizedBox.shrink();

    return VisibilityDetector(
      key: const Key('bride-groom-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                if (_isVisible) ...[
                  Text(
                    "Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta'ala, kami mengundang Bapak/Ibu/Saudara/i untuk hadir di acara pernikahan kami:",
                    style: AppStyles.bodyStyle.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 50),
                  
                  Text(
                    "Mempelai",
                    style: AppStyles.scriptStyle.copyWith(fontSize: 42),
                  ).animate().fadeIn(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 60),
                  
                  _buildPersonInfo(
                    invitation.brideFullName,
                    "Anak Sulung dari Bapak Lukam & Ibu Diah",
                    "assets/gambar/CEWE.png",
                    0,
                    true, // bride
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Text(
                    "&",
                    style: AppStyles.scriptStyle.copyWith(fontSize: 50, color: AppColors.accent),
                  ).animate().fadeIn(delay: 600.ms).scale(),
                  
                  const SizedBox(height: 40),
                  
                  _buildPersonInfo(
                    invitation.groomFullName,
                    "Putra dari Bapak Jailanih bin Jakwan bin Kaming\n& Ibu Pipit Aryani Binti Arnali",
                    "assets/gambar/COWO.png",
                    800,
                    false, // groom
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonInfo(String name, String parents, String imgPath, int delay, bool isBride) {
    return Column(
      children: [
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ).animate().fadeIn(delay: delay.ms, duration: 800.ms).slideX(begin: isBride ? -0.2 : 0.2),
        
        const SizedBox(height: 30),
        
        Text(
          name,
          style: AppStyles.scriptStyle.copyWith(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: (delay + 200).ms).slideX(begin: isBride ? -0.2 : 0.2),
        
        const SizedBox(height: 10),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            parents,
            style: AppStyles.bodyStyle.copyWith(
              fontSize: 13,
              color: AppColors.primaryText.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ).animate().fadeIn(delay: (delay + 400).ms).slideX(begin: isBride ? -0.2 : 0.2),
      ],
    );
  }
}
