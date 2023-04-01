import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../../../config/providers.dart';
import '../../../../../../core/error_handling/failures.dart';
import '../../../data/repositories/client_tracking_sessions_repo.dart';
part 'client_add_session_state.dart';

final clientAddSessionProvider = StateNotifierProvider.autoDispose<ClientAddSessionProvider,ClientAddSessionState>(
  (ref) => ClientAddSessionProvider(ref.read(clientTrackingSessionsRepositoryProvider),)
);

class ClientAddSessionProvider extends StateNotifier<ClientAddSessionState> {
  final ClientTrackingSessionsRepository _clientTrackingSessionRepository;
  ClientAddSessionProvider(this._clientTrackingSessionRepository) : super(ClientAddSessionInitial());

  Future<void> addSession({
    required String sessionName,
    required String sessionPassword,
    required String clientId,
  }) async{
    state = ClientAddSessionLoading();

    final addSessionResults = await _clientTrackingSessionRepository.addSession(
        clientId: clientId,
        sessionName:sessionName ,
        sessionPassword: sessionPassword
    );

    await addSessionResults.fold(
        (failure){
          state = ClientAddSessionError(failure);
        },
        (results) async{
          state = ClientAddSessionDone();
        }
    );
  }

}
