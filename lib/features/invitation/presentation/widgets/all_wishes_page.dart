import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';

class AllWishesPage extends StatelessWidget {
  const AllWishesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Semua Ucapan & Doa", style: AppStyles.headingStyle.copyWith(fontSize: 18)),
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: invitation.wishes.length,
            itemBuilder: (context, index) {
              final wish = invitation.wishes[index];
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      wish.message,
                      style: AppStyles.bodyStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      wish.date,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1);
            },
          ),
        ),
      ),
    );
  }
}
