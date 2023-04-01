import 'package:flutter_projects/config/providers.dart';
import 'package:riverpod/riverpod.dart';

final clientLocationProvider = StreamProvider.family.autoDispose<dynamic,String>(
  (ref,locationId){
    final results = ref.read(clientLocationRepositoryProvider).getClientLocation(locationId);
    return results;
  }
);
