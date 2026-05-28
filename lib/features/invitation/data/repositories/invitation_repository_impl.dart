import '../../domain/entities/invitation.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../datasources/local_datasource.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  final LocalDataSource localDataSource;

  InvitationRepositoryImpl({required this.localDataSource});

  @override
  Future<Invitation> getInvitationData() async {
    return await localDataSource.getInvitation();
  }
}
