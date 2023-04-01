import 'package:flutter_projects/core/utils/real_time_manager.dart';
import 'package:flutter_projects/features/auth/data/data_sources/reset_password_remote.dart';
import 'package:flutter_projects/features/auth/data/repositories/reset_password_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../core/utils/connectivity_watcher.dart';
import '../core/utils/crypto_service.dart';
import '../core/utils/geo_service.dart';
import '../core/utils/network_checker.dart';
import '../features/auth/data/data_sources/auth_remote.dart';
import '../features/auth/data/data_sources/email_verification_remote.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/data/repositories/email_verification_repo.dart';
import '../features/profile/data/data_sources/profile_user_remote.dart';
import '../features/profile/data/repositories/profile_user_repo.dart';
import '../features/tracker/home/data/data_sources/client_data_remote.dart';
import '../features/client/home/data/data_sources/client_tracking_sessions_remote.dart';
import '../features/client/home/data/repositories/client_tracking_sessions_repo.dart';
import '../features/client/home/data/data_sources/update_location_remote.dart';
import '../features/client/home/data/repositories/update_location_repo.dart';
import '../features/home/data/data_sources/user_data_remote.dart';
import '../features/tracker/home/data/repositories/client_data_repo.dart';
import '../features/home/data/repositories/user_data_repo.dart';
import '../features/client/home/data/data_sources/tracker_data_remote.dart';
import '../features/tracker/home/data/data_sources/tracker_tracking_sessions_remote.dart';
import '../features/client/home/data/repositories/tracker_data_repo.dart';
import '../features/map/data/data_sources/client_location_remote.dart';
import '../features/map/data/repositories/client_location_repo.dart';
import '../features/tracker/home/data/repositories/tracker_tracking_sessions_repo.dart';

//! Utils
  //! ---- Network Info ----
  final networkInfoProvider = Provider<NetworkInfo>((ref) {
    final InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker();
    return NetworkInfo(internetConnectionChecker);
  });

  //! ---- GEO Service ---
  final geoServiceProvider = Provider.autoDispose<GEOService>((ref) {
    return GEOService();
  });

  //! ---- Crypto Service ---
  final cryptoProvider = Provider.autoDispose<CryptoService>((ref) {
    return CryptoService();
  });

  //! ---- Real time manager ----
  final realTimeManagerProvider = Provider<RealTimeManager>((ref) {
    return RealTimeManager();
  });

  //! ---- Connectivity Service ----
  final connectivityWatcherProvider = Provider<ConnectivityWatcher>((ref) {
    return ConnectivityWatcher();
  });

  //! ---- profile_user ----
  final profileUserRemoteProvider = Provider.autoDispose<ProfileUserRemote>((ref) => ProfileUserRemote());

  final profileUserRepositoryProvider = Provider.autoDispose<ProfileUserRepository>((ref) {
    final profileUserRemoteRef = ref.read(profileUserRemoteProvider);
    final networkInfoRef = ref.read(networkInfoProvider);

    return ProfileUserRepositoryImpl(profileUserRemoteRef,networkInfoRef);
  });

//! ---- Features ----
  //! ---- Auth ----
    //! ---- Email Verification ----
    final _emailVerificationRemoteProvider = Provider.autoDispose<EmailVerificationRemote>((ref) => EmailVerificationRemote());

    final emailVerificationRepositoryProvider = Provider.autoDispose<EmailVerificationRepositoryImpl>((ref) {
      final emailVerificationRemoteRef = ref.read(_emailVerificationRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return EmailVerificationRepositoryImpl(emailVerificationRemoteRef,networkInfoRef);
    });

    //! ---- Login,register,credential ----
    final _authRemoteProvider = Provider.autoDispose<AuthRemote>((ref) => AuthRemote());

    final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
      final authRemoteRef = ref.read(_authRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return AuthRepositoryImpl(authRemoteRef,networkInfoRef);
    });

    //! ---- reset password ----
    final _resetPasswordProvider = Provider.autoDispose<ResetPasswordRemote>((ref) => ResetPasswordRemote());

    final resetPasswordRepositoryProvider = Provider.autoDispose<ResetPasswordRepository>((ref) {
      final resetPasswordRemoteRef = ref.read(_resetPasswordProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return ResetPasswordRepositoryImpl(resetPasswordRemoteRef,networkInfoRef);
    });

  //! ---- Home ----
    //! ---- user_data ----
    final userDataRemoteProvider = Provider.autoDispose<UserDataRemote>((ref) => UserDataRemote());

    final userDataRepositoryProvider = Provider.autoDispose<UserDataRepository>((ref) {
      final userDataRemoteRef = ref.read(userDataRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return UserDataRepositoryImpl(userDataRemoteRef,networkInfoRef);
    });

  //! ---- Client ----
    //! ---- Home ----
    final _clientTrackingSessionsRemoteProvider = Provider.autoDispose<ClientTrackingSessionsRemote>((ref) => ClientTrackingSessionsRemote());

    final clientTrackingSessionsRepositoryProvider = Provider.autoDispose<ClientTrackingSessionsRepository>((ref) {
      final clientTrackingSessionsRemoteRef = ref.read(_clientTrackingSessionsRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);
      final cryptoRef = ref.read(cryptoProvider);

      return ClientTrackingSessionsRepositoryImpl(clientTrackingSessionsRemoteRef,networkInfoRef,cryptoRef);
    });

    //! ---- client_data ----
    final _clientDataRemoteProvider = Provider.autoDispose<ClientDataRemote>((ref) => ClientDataRemote());

    final clientDataRepositoryProvider = Provider.autoDispose<ClientDataRepository>((ref) {
      final clientDataRemoteRef = ref.read(_clientDataRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return ClientDataRepositoryImpl(clientDataRemoteRef,networkInfoRef);
    });

    //! ---- update_location ----
    final updateLocationRemoteProvider = Provider.autoDispose<UpdateLocationRemote>((ref) => UpdateLocationRemote());

    final updateLocationRepositoryProvider = Provider.autoDispose<UpdateLocationRepository>((ref) {
      final updateLocationRemoteRef = ref.read(updateLocationRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return UpdateLocationRepositoryImpl(updateLocationRemoteRef,networkInfoRef);
    });

//! ---- Tracker ----
    //! ---- Home ----
    final _trackerTrackingSessionsRemoteProvider = Provider.autoDispose<TrackerTrackingSessionsRemote>((ref) => TrackerTrackingSessionsRemote());

    final trackerTrackingSessionsRepositoryProvider = Provider.autoDispose<TrackerTrackingSessionsRepository>((ref) {
      final trackerTrackingSessionsRemoteRef = ref.read(_trackerTrackingSessionsRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);
      final cryptoRef = ref.read(cryptoProvider);

      return TrackerTrackingSessionsRepositoryImpl(trackerTrackingSessionsRemoteRef,networkInfoRef,cryptoRef);
    });

    //! ---- tracker_data ----
    final trackerDataRemoteProvider = Provider.autoDispose<TrackerDataRemote>((ref) => TrackerDataRemote());

    final trackerDataRepositoryProvider = Provider.autoDispose<TrackersDataRepository>((ref) {
      final trackerDataRemoteRef = ref.read(trackerDataRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return TrackersDataRepositoryImpl(trackerDataRemoteRef,networkInfoRef);
    });

  // ---- map ----
    //! ---- client_location ----
    final _clientLocationRemoteProvider = Provider.autoDispose<ClientLocationRemote>((ref) => ClientLocationRemote());

    final clientLocationRepositoryProvider = Provider.autoDispose<ClientLocationRepository>((ref) {
      final clientLocationRemoteRef = ref.read(_clientLocationRemoteProvider);
      final networkInfoRef = ref.read(networkInfoProvider);

      return ClientLocationRepositoryImpl(clientLocationRemoteRef,networkInfoRef);
    });