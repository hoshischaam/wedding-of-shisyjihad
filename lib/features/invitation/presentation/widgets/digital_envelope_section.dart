import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';

class DigitalEnvelopeSection extends StatefulWidget {
  const DigitalEnvelopeSection({Key? key}) : super(key: key);

  @override
  State<DigitalEnvelopeSection> createState() => _DigitalEnvelopeSectionState();
}

class _DigitalEnvelopeSectionState extends State<DigitalEnvelopeSection> {
  bool _isVisible = false;

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Nomor rekening berhasil disalin!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>().invitationData;
    if (invitation == null) return const SizedBox.shrink();

    return VisibilityDetector(
      key: const Key('digital-envelope-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        color: AppColors.background,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                if (_isVisible) ...[
                  Text("Amplop Digital", style: AppStyles.scriptStyle.copyWith(fontSize: 48))
                      .animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  const SizedBox(height: 10),
                  const Text(
                    "Doa restu Anda merupakan karunia yang sangat berarti bagi kami. Namun apabila Anda ingin memberikan tanda kasih, Anda dapat memberikannya melalui:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 40),
                  ...invitation.banks.map((bank) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: CustomPaint(
                        painter: DashedBorderPainter(color: AppColors.accent, borderRadius: 20),
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              if (bank.bank.toUpperCase().contains('BCA'))
                                Image.asset(
                                  'assets/gambar/logo_bca.png',
                                  height: 40,
                                  fit: BoxFit.contain,
                                )
                              else if (bank.bank.toUpperCase().contains('BSI'))
                                Image.asset(
                                  'assets/gambar/logo_bsi.png',
                                  height: 40,
                                  fit: BoxFit.contain,
                                )
                              else
                                const Icon(Icons.credit_card, color: AppColors.accent, size: 30),
                              const SizedBox(height: 15),
                              Text(
                                bank.bank,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                bank.number,
                                style: const TextStyle(fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "a.n ${bank.name}",
                                style: AppStyles.bodyStyle.copyWith(fontSize: 13),
                              ),
                              const SizedBox(height: 20),
                              OutlinedButton.icon(
                                onPressed: () => _copyToClipboard(context, bank.number),
                                icon: const Icon(Icons.copy, size: 14),
                                label: const Text("SALIN NO REKENING"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.accent,
                                  side: const BorderSide(color: AppColors.accent),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95));
                  }).toList(),
                  
                  const SizedBox(height: 50),
                  Text(
                    "KIRIM KADO",
                    style: AppStyles.headingStyle.copyWith(fontSize: 16, letterSpacing: 2),
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 15),
                  Text(
                    invitation.giftReceiver,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ).animate().fadeIn(delay: 700.ms),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      invitation.giftAddress,
                      textAlign: TextAlign.center,
                      style: AppStyles.bodyStyle.copyWith(fontSize: 13),
                    ),
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  DashedBorderPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    const dashWidth = 5.0;
    const dashSpace = 5.0;
    var distance = 0.0;

    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
