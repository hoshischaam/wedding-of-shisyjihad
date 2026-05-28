import 'package:flutter/material.dart';
import 'package:wedding_invitation/core/services/google_sheets_service.dart';
import '../../domain/entities/invitation.dart';
import '../../domain/repositories/invitation_repository.dart';

class InvitationProvider extends ChangeNotifier {
  final InvitationRepository repository;
  final GoogleSheetsService sheetsService;

  InvitationProvider({
    required this.repository, 
    required this.sheetsService
  });

  bool _isOpened = false;
  String _guestName = "Tamu Undangan";
  Invitation? _invitationData;
  bool _isLoading = true;
  List<Wish> _wishes = [];
  bool _isSubmittingRsvp = false;

  bool get isOpened => _isOpened;
  String get guestName => _guestName;
  Invitation? get invitationData => _invitationData;
  bool get isLoading => _isLoading;
  List<Wish> get wishes => _wishes;
  bool get isSubmittingRsvp => _isSubmittingRsvp;

  void openInvitation() {
    _isOpened = true;
    notifyListeners();
  }

  Future<void> loadInvitationData() async {
    _isLoading = true;
    notifyListeners();
    
    // Load static data
    _invitationData = await repository.getInvitationData();
    
    // Load real-time wishes from Google Sheets
    await refreshWishes();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshWishes() async {
    final rawWishes = await sheetsService.getWishes();
    // Jika data berhasil diambil (meskipun kosong)
    _wishes = rawWishes.map((w) => Wish(
      name: w['nama'] ?? 'Tamu',
      date: w['tanggal']?.toString() ?? '',
      message: w['pesan'] ?? '',
    )).toList();
    
    // Jika benar-benar gagal ambil data (error network), baru pakai dummy
    if (rawWishes.isEmpty && _invitationData != null && _wishes.isEmpty) {
      // Kita cek apakah ini benar-benar kosong atau error
      // Untuk sementara, jika kosong kita biarkan kosong agar user tahu datanya masuk
    }
    notifyListeners();
  }

  Future<bool> submitRsvp(String name, String status, String message) async {
    _isSubmittingRsvp = true;
    notifyListeners();

    final success = await sheetsService.submitRsvp(
      name: name,
      status: status,
      message: message,
    );

    if (success) {
      // Refresh wishes after successful post
      await refreshWishes();
    }

    _isSubmittingRsvp = false;
    notifyListeners();
    return success;
  }

  void initializeFromUrl() {
    final uri = Uri.base;
    if (uri.queryParameters.containsKey('to')) {
      // Mengambil nama dari parameter ?to=Nama+Tamu
      // Kita bersihkan karakter + atau %20 menjadi spasi agar rapi
      String rawName = uri.queryParameters['to']!;
      _guestName = rawName.replaceAll('+', ' ').replaceAll('%20', ' ');
      notifyListeners();
    }
  }
}
