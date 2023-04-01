import 'package:flutter_projects/config/providers.dart';
import 'package:riverpod/riverpod.dart';

final trackerDataProvider = StreamProvider.autoDispose.family<dynamic,String>(
    (ref,trackerId) async*{
      if(trackerId.isEmpty){
        yield null;
      }else{
        yield* ref.read(trackerDataRepositoryProvider).getTrackerData(trackerId);
      }
    }
);

