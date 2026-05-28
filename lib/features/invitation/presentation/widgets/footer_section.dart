import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>().invitationData;
    if (invitation == null) return const SizedBox.shrink();

    return VisibilityDetector(
      key: const Key('footer-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundSecondary,
        ),
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                if (_isVisible) ...[
                  Text(
                    "Terima Kasih",
                    style: AppStyles.scriptStyle.copyWith(fontSize: 48),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 30),
                  
                  Text(
                    "Merupakan suatu kehormatan dan kebahagiaan bagi kami apabila Bapak/Ibu/Saudara/i berkenan hadir untuk memberikan doa restu kepada kami.",
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyStyle.copyWith(fontSize: 14, height: 1.6),
                  ).animate().fadeIn(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 60),
                  
                  Text(
                    "Kami yang berbahagia,",
                    style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.w600),
                  ).animate().fadeIn(delay: 600.ms),
                  
                  const SizedBox(height: 15),
                  
                  Text(
                    "${invitation.brideName} & ${invitation.groomName}",
                    style: AppStyles.scriptStyle.copyWith(fontSize: 36),
                  ).animate().fadeIn(delay: 800.ms).scale(),
                  
                  const SizedBox(height: 80),
                  
                  Text(
                    "THE WEDDING OF",
                    style: AppStyles.bodyStyle.copyWith(
                      fontSize: 10,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText.withOpacity(0.5),
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  
                  const SizedBox(height: 10),
                  
                  Text(
                    "${invitation.brideName} & ${invitation.groomName}",
                    style: AppStyles.scriptStyle.copyWith(
                      fontSize: 24,
                      color: AppColors.primaryText.withOpacity(0.5),
                    ),
                  ).animate().fadeIn(delay: 1100.ms),
                  
                  const SizedBox(height: 40),
                  
                  Text(
                    "© 2026 by Beloved Brother",
                    style: AppStyles.bodyStyle.copyWith(
                      fontSize: 10,
                      color: AppColors.primaryText.withOpacity(0.4),
                    ),
                  ).animate().fadeIn(delay: 1300.ms),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
