import 'package:flutter/material.dart';
import '../models/invitation_model.dart';
import '../../domain/entities/invitation.dart';

class LocalDataSource {
  Future<InvitationModel> getInvitation() async {
    return InvitationModel(
      groomName: "Jihad",
      brideName: "Sissy",
      groomFullName: "Moh. Jihad, S.T.",
      brideFullName: "Sissy Hisanah, S.Pd.",
      eventDate: "Minggu, 12 Desember 2026",
      akadTime: "09:00 - 10:00 WIB",
      resepsiTime: "10:00 - Selesai WIB",
      locationName: "Kediaman Mempelai Wanita",
      locationAddress: "Jl. Teuku Cikditiro Gg Mawar 1 Sumberrejo Kemiling",
      mapsUrl: "https://maps.google.com/?q=-5.3971,105.2663",
      dummyCoverUrl: "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80",
      groomPhotoUrl: "https://images.unsplash.com/photo-1549473448-5d7196c91f48?auto=format&fit=crop&w=400&q=80",
      bridePhotoUrl: "https://images.unsplash.com/photo-1534008897995-27a23e859048?auto=format&fit=crop&w=400&q=80",
      galleryPhotos: [
        "https://images.unsplash.com/photo-1511285560929-80b456fea0bc?auto=format&fit=crop&w=600&q=80",
        "https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=600&q=80",
        "https://images.unsplash.com/photo-1519225421980-715cb0215aed?auto=format&fit=crop&w=600&q=80",
        "https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?auto=format&fit=crop&w=600&q=80",
        "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?auto=format&fit=crop&w=600&q=80",
        "https://images.unsplash.com/photo-1509927083803-4bd519298ac4?auto=format&fit=crop&w=600&q=80",
      ],
      targetDate: DateTime(2026, 12, 12, 9, 0, 0),
      youtubeVideoId: "R2QGZijERtw",
      protocols: [
        ProtocolItem(icon: Icons.masks, text: "Memakai Masker"),
        ProtocolItem(icon: Icons.social_distance, text: "Menjaga Jarak"),
        ProtocolItem(icon: Icons.wash, text: "Mencuci Tangan"),
        ProtocolItem(icon: Icons.groups_outlined, text: "Menghindari Kerumunan"),
        ProtocolItem(icon: Icons.sanitizer, text: "Menggunakan Handsanitizer"),
        ProtocolItem(icon: Icons.handshake_outlined, text: "Menghindari Berjabat Tangan"),
      ],
      loveStory: [
        LoveStoryItem(
          title: "First Date",
          subtitle: "Pertama kali kami bertemu dan dikenalkan sebagai teman satu kampus dan kebetulan kami masih memiliki cerita masing-masing."
        ),
        LoveStoryItem(
          title: "Akad Nikah",
          subtitle: "Setelah beberapa tahun kami saling kenal, semakin membuat kami yakin satu sama lain untuk melangkah lebih jauh. Sehingga kami yakinkan diri sampai di tahap pelamaran."
        ),
        LoveStoryItem(
          title: "The Wedding",
          subtitle: "Akhir dari perjalanan pencarian kami masing-masing sampailah pada tahap kami untuk memulai awal cerita kami bersama sebagai keluarga yang In Syaa Allah kami yakin untuk membangunnya bersama. Semoga langkah kami selalu diberkahi dan diridhakan oleh Allah SWT."
        )
      ],
      banks: [
        BankDetails(bank: "BANK MANDIRI", name: "MOH. JIHAD", number: "210002114"),
        BankDetails(bank: "BANK MANDIRI", name: "SISSY HISANAH", number: "210002136"),
      ],
      giftAddress: "Jl. Teuku Cikditiro Gg Mawar 1 Sumberrejo Kemiling",
      giftReceiver: "Sissy Hisanah",
      dummyWishes: [
        Wish(name: "Aku", date: "24 Oktober 2025 | 10:07", message: "Selamat menempuh hidup baru ya!"),
        Wish(name: "Abdul Seo", date: "24 November 2024 | 21:21", message: "Selamat ya kak"),
        Wish(name: "Trisna Puji", date: "10 Februari 2022 | 00:00", message: "Selamat menempuh hidup baru ya bestieeee"),
        Wish(name: "Adji Sukmana", date: "10 Februari 2022 | 01:00", message: "Selamat ya kak semoga samawa"),
      ],
      venueLatitude: -6.21462,
      venueLongitude: 106.80232,
    );
  }
}
