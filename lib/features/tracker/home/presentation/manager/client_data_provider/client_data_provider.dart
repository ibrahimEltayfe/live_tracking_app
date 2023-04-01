import 'package:flutter_projects/config/providers.dart';
import 'package:riverpod/riverpod.dart';

final clientDataProvider = StreamProvider.autoDispose.family<dynamic,String>(
  (ref,clientId) async*{
    if(clientId.isEmpty){
      yield null;
    }else{
      yield* ref.read(clientDataRepositoryProvider).getClientData(clientId);
    }
 }
);

