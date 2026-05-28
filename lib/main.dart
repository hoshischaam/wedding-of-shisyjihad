import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'core/app_colors.dart';
import 'core/services/google_sheets_service.dart';
import 'features/invitation/data/datasources/local_datasource.dart';
import 'features/invitation/data/repositories/invitation_repository_impl.dart';
import 'features/invitation/presentation/providers/invitation_provider.dart';
import 'features/invitation/presentation/widgets/hero_section.dart';
import 'features/invitation/presentation/widgets/bride_groom_section.dart';
import 'features/invitation/presentation/widgets/location_section.dart';
import 'features/invitation/presentation/widgets/audio_controller.dart';
import 'features/invitation/presentation/widgets/cover_section.dart';
import 'features/invitation/presentation/widgets/digital_envelope_section.dart';
import 'features/invitation/presentation/widgets/rsvp_wishes_section.dart';
import 'features/invitation/presentation/widgets/footer_section.dart';

void main() {
  Animate.defaultDuration = 1200.ms;
  
  // Setup Dependencies
  final localDataSource = LocalDataSource();
  final repository = InvitationRepositoryImpl(localDataSource: localDataSource);
  
  // Initialize Google Sheets Service
  const scriptUrl = "https://script.google.com/macros/s/AKfycbwFr3rl26_EHPTw_mO8shUJoYNelQz4LFQvIf75V-EQ3KwVp6WHefMhDrTclIEwX0TccQ/exec";
  final sheetsService = GoogleSheetsService(scriptUrl);

  runApp(
    ChangeNotifierProvider(
      create: (context) => InvitationProvider(
        repository: repository,
        sheetsService: sheetsService,
      )
        ..initializeFromUrl()
        ..loadInvitationData(),
      child: const InvitationApp(),
    ),
  );
}

class InvitationApp extends StatelessWidget {
  const InvitationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Invitation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryText,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>();

    if (invitation.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // 1. Tampilan Isi Undangan (Full Width Snap ListView)
          if (invitation.isOpened)
            Container(
              color: AppColors.background,
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                physics: const BouncingScrollPhysics(), // Scroll halus dan bebas
                children: const [
                  _PageWrapper(child: HeroSection()),
                  _PageWrapper(child: BrideGroomSection()),
                  _PageWrapper(child: LocationSection()),                
                  _PageWrapper(child: DigitalEnvelopeSection()),
                  _PageWrapper(child: RsvpWishesSection()),
                  _PageWrapper(child: FooterSection()),
                ],
              ),
            ),

          // 2. Floating Audio Controller
          if (invitation.isOpened)
            const AudioControllerWidget(),

          // 3. Cover Section (Fullscreen)
          if (!invitation.isOpened)
            Positioned.fill(
              child: CoverSection(
                onOpen: () => invitation.openInvitation(),
                guestName: invitation.guestName,
              ).animate().fadeIn(duration: 800.ms),
            ),
        ],
      ),
    );
  }
}

class _PageWrapper extends StatelessWidget {
  final Widget child;
  const _PageWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: child,
    );
  }
}
