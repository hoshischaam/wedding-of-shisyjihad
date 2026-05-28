import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('hero-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
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
                    "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
                    style: AppStyles.arabicStyle.copyWith(
                      fontSize: 32,
                      color: AppColors.accent,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 25),
                  
                  Text(
                    "Assalamu'alaikum Warahmatullahi Wabarakatuh",
                    style: AppStyles.bodyStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
                  
                  const SizedBox(height: 50),
                  
                  // Boxed Ayat Section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.accent.withOpacity(0.15)),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "وَمِنْ ءَايَٰتِهِۦٓ أَنْ خَلَقَ لَكُم مِّنْ أَنفُسِكُمْ أَزْوَٰجًا لِّتَسْكُنُوٓا۟ إِلَيْهَا وَجَعَلَ بَيْنَكُم مَّوَدَّةً وَرَحْمَةً ۚ إِنَّ فِى ذَٰلِكَ لَءَايَٰتٍ لِّقَوْمٍ يَتَفَكَّرُونَ",
                          style: AppStyles.arabicStyle.copyWith(
                            fontSize: 22,
                            height: 2.2,
                            color: AppColors.accent,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
                        
                        const SizedBox(height: 25),
                        
                        Text(
                          "\"Dan di antara tanda-tanda kekuasaan-Nya ialah Dia menciptakan untukmu isteri-isteri dari jenismu sendiri, supaya kamu cenderung dan merasa tenteram kepadanya, dan dijadikan-Nya diantaramu rasa kasih dan sayang.\"",
                          style: AppStyles.bodyStyle.copyWith(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: AppColors.primaryText.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 900.ms, duration: 800.ms),
                        
                        const SizedBox(height: 10),
                        
                        Text(
                          "(QS. Ar-Rum: 21)",
                          style: AppStyles.bodyStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 1100.ms),
                      ],
                    ),
                  ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.95, 0.95)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
