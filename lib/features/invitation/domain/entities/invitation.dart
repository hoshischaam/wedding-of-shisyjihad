import 'package:flutter/material.dart';

class Invitation {
  final String groomName;
  final String brideName;
  final String groomFullName;
  final String brideFullName;
  final String eventDate;
  final String akadTime;
  final String resepsiTime;
  final String locationName;
  final String locationAddress;
  final String mapsUrl;
  final String dummyCoverUrl;
  final String groomPhotoUrl;
  final String bridePhotoUrl;
  final List<String> galleryPhotos;
  final DateTime targetDate;
  final String youtubeVideoId;
  final List<ProtocolItem> protocols;
  final List<LoveStoryItem> loveStory;
  final List<BankDetails> banks;
  final String giftAddress;
  final String giftReceiver;
  final List<Wish> dummyWishes;
  final double venueLatitude;
  final double venueLongitude;

  Invitation({
    required this.groomName,
    required this.brideName,
    required this.groomFullName,
    required this.brideFullName,
    required this.eventDate,
    required this.akadTime,
    required this.resepsiTime,
    required this.locationName,
    required this.locationAddress,
    required this.mapsUrl,
    required this.dummyCoverUrl,
    required this.groomPhotoUrl,
    required this.bridePhotoUrl,
    required this.galleryPhotos,
    required this.targetDate,
    required this.youtubeVideoId,
    required this.protocols,
    required this.loveStory,
    required this.banks,
    required this.giftAddress,
    required this.giftReceiver,
    required this.dummyWishes,
    required this.venueLatitude,
    required this.venueLongitude,
  });
}

class ProtocolItem {
  final IconData icon;
  final String text;
  ProtocolItem({required this.icon, required this.text});
}

class LoveStoryItem {
  final String title;
  final String subtitle;
  LoveStoryItem({required this.title, required this.subtitle});
}

class BankDetails {
  final String bank;
  final String name;
  final String number;
  BankDetails({required this.bank, required this.name, required this.number});
}

class Wish {
  final String name;
  final String date;
  final String message;
  Wish({required this.name, required this.date, required this.message});
}
