import '../entities/invitation.dart';

abstract class InvitationRepository {
  Future<Invitation> getInvitationData();
}
