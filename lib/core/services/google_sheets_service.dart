import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsService {
  final String scriptUrl;

  GoogleSheetsService(this.scriptUrl);

  /// Mengambil daftar ucapan doa dari Google Sheets
  Future<List<Map<String, dynamic>>> getWishes() async {
    try {
      final response = await http.get(
        Uri.parse('$scriptUrl?action=getWishes'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      }
      return [];
    } catch (e) {
      print("Error fetching wishes: $e");
      return [];
    }
  }

  /// Mengirim data RSVP (Kehadiran & Ucapan)
  Future<bool> submitRsvp({
    required String name,
    required String status,
    required String message,
  }) async {
    try {
      // PENTING: Gunakan 'text/plain' agar browser tidak mengirim preflight OPTIONS
      // yang seringkali diblokir oleh Google Apps Script (CORS issue).
      final response = await http.post(
        Uri.parse(scriptUrl),
        headers: {
          "Content-Type": "text/plain", 
        },
        body: json.encode({
          'nama': name,
          'status': status,
          'pesan': message,
        }),
      );
      
      // Google Apps Script akan merespon dengan status 200 jika berhasil
      return response.statusCode == 200 || response.statusCode == 302;
    } catch (e) {
      print("Error submitting RSVP: $e");
      return false;
    }
  }
}
