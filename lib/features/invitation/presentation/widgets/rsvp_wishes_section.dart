import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';
import 'all_wishes_page.dart';

class RsvpWishesSection extends StatefulWidget {
  const RsvpWishesSection({Key? key}) : super(key: key);

  @override
  State<RsvpWishesSection> createState() => _RsvpWishesSectionState();
}

class _RsvpWishesSectionState extends State<RsvpWishesSection> {
  bool _isVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _attendanceStatus = "Hadir";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final invitation = context.read<InvitationProvider>();
      if (invitation.guestName != "Tamu Undangan") {
        _nameController.text = invitation.guestName;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitRsvp() async {
    final invitation = context.read<InvitationProvider>();
    if (_nameController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi nama dan ucapan Anda.")),
      );
      return;
    }

    final success = await invitation.submitRsvp(
      _nameController.text,
      _attendanceStatus,
      _messageController.text,
    );

    if (success && mounted) {
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ucapan dan RSVP berhasil dikirim!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>();
    if (invitation.invitationData == null) return const SizedBox.shrink();

    // Ambil maksimal 5 ucapan terbaru untuk ditampilkan di depan
    final displayedWishes = invitation.wishes.take(5).toList();

    return VisibilityDetector(
      key: const Key('rsvp-wishes-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        color: Colors.white,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                if (_isVisible) ...[
                  Text("RSVP & Ucapan", style: AppStyles.scriptStyle.copyWith(fontSize: 48))
                      .animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  const SizedBox(height: 10),
                  const Text(
                    "Kehadiran dan doa restu Anda adalah kado terindah bagi kami. Mohon konfirmasi kehadiran Anda:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 40),
                  
                  // RSVP Form
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F7F2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Nama Anda",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _attendanceStatus,
                              isExpanded: true,
                              items: ["Hadir", "Tidak Hadir"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _attendanceStatus = val);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Tulis Ucapan & Doa",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: invitation.isSubmittingRsvp ? null : _submitRsvp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: invitation.isSubmittingRsvp 
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text("Kirim Ucapan"),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 60),

                  // Wishes List (Limited to 5)
                  Column(
                    children: displayedWishes.map((wish) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F7F2),
                          borderRadius: BorderRadius.circular(12),
                          border: const Border(
                            left: BorderSide(color: AppColors.accent, width: 5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wish.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              wish.message,
                              style: AppStyles.bodyStyle.copyWith(fontSize: 14, color: Colors.black87),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              wish.date,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 800.ms);
                    }).toList(),
                  ),

                  // Tombol Lihat Semua (Jika > 5)
                  if (invitation.wishes.length > 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AllWishesPage()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.accent,
                          side: const BorderSide(color: AppColors.accent),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Lihat Semua Ucapan"),
                      ),
                    ).animate().fadeIn(delay: 500.ms),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
