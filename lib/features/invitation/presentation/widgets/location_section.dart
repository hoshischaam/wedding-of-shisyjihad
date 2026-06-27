import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../providers/invitation_provider.dart';
import 'countdown_section.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({Key? key}) : super(key: key);

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  bool _isVisible = false;

  Future<void> _openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final invitation = context.watch<InvitationProvider>().invitationData;
    if (invitation == null) return const SizedBox.shrink();

    return VisibilityDetector(
      key: const Key('location-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_isVisible) {
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
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                if (_isVisible) ...[
                  Text(
                    "Waktu & Lokasi",
                    style: AppStyles.scriptStyle.copyWith(fontSize: 42),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 30),
                  
                  const CountdownSection(),
                  
                  const SizedBox(height: 40),
                  
                  _buildEventCard(
                    "Akad & Resepsi",
                    "Sabtu",
                    "11 Juli 2026",
                    "10.00 - 14.00 WIB",
                    "Masjid Nurul Iman Srengseng\nJl. Raya Pos Pengumben No.21 RT 10/03 Srengseng, Kec. Kembangan, Jakarta Barat",
                    invitation.mapsUrl,
                    0
                  ),
                  
               
                  
                  const SizedBox(height: 30),
                  
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(invitation.venueLatitude, invitation.venueLongitude),
                          initialZoom: 15.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(invitation.venueLatitude, invitation.venueLongitude),
                                width: 80,
                                height: 80,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Color(0xFFC0392B),
                                  size: 45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 800.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 40),
                  
                  ElevatedButton.icon(
                    onPressed: () => _openUrl(invitation.mapsUrl),
                    icon: const Icon(Icons.location_on_outlined, size: 18),
                    label: const Text("PETUNJUK LOKASI"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
                    ),
                  ).animate().fadeIn(delay: 700.ms),
                  
                  const SizedBox(height: 30),
                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.local_parking_rounded,
                              color: AppColors.accent,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "LOKASI PARKIR",
                              style: AppStyles.headingStyle.copyWith(
                                fontSize: 16,
                                color: AppColors.accent,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          invitation.parkingName,
                          style: AppStyles.bodyStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          invitation.parkingAddress,
                          style: AppStyles.bodyStyle.copyWith(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(invitation.parkingLatitude, invitation.parkingLongitude),
                                initialZoom: 16.0,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: LatLng(invitation.parkingLatitude, invitation.parkingLongitude),
                                      width: 80,
                                      height: 80,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.15),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.blue.shade700,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.local_parking_rounded,
                                          color: Colors.blue.shade700,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton.icon(
                          onPressed: () => _openUrl(invitation.parkingMapsUrl),
                          icon: const Icon(Icons.directions_car_outlined, size: 18),
                          label: const Text("PETUNJUK LOKASI PARKIR"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent.withOpacity(0.1),
                            foregroundColor: AppColors.accent,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: AppColors.accent, width: 1.5),
                            ),
                            textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.2),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(String title, String day, String date, String time, String location, String mapsUrl, int delay) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: AppStyles.headingStyle.copyWith(
              fontSize: 18,
              color: AppColors.accent,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "$day, $date",
            style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            "Pukul $time",
            style: AppStyles.bodyStyle.copyWith(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: AppColors.accent.withOpacity(0.1), thickness: 1),
          ),
          const SizedBox(height: 25),
          Text(
            location,
            style: AppStyles.bodyStyle.copyWith(fontSize: 14, height: 1.7),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms, duration: 800.ms).slideY(begin: 0.2);
  }
}
