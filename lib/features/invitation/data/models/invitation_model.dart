import '../../domain/entities/invitation.dart';

class InvitationModel extends Invitation {
  InvitationModel({
    required super.groomName,
    required super.brideName,
    required super.groomFullName,
    required super.brideFullName,
    required super.eventDate,
    required super.akadTime,
    required super.resepsiTime,
    required super.locationName,
    required super.locationAddress,
    required super.mapsUrl,
    required super.dummyCoverUrl,
    required super.groomPhotoUrl,
    required super.bridePhotoUrl,
    required super.galleryPhotos,
    required super.targetDate,
    required super.youtubeVideoId,
    required super.protocols,
    required super.loveStory,
    required super.banks,
    required super.giftAddress,
    required super.giftReceiver,
    required super.dummyWishes,
    required super.venueLatitude,
    required super.venueLongitude,
    required super.parkingName,
    required super.parkingAddress,
    required super.parkingMapsUrl,
    required super.parkingLatitude,
    required super.parkingLongitude,
  });

  // You can add fromJson/toJson here if you fetch from API in the future
}
