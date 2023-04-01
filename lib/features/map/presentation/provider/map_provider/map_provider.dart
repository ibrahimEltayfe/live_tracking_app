import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/riverpod.dart';
part 'map_state.dart';

final mapProvider = StateNotifierProvider.autoDispose<MapProvider,MapState>(
  (ref) => MapProvider()
);

class MapProvider extends StateNotifier<MapState> {
  MapProvider() : super(MapInitial());
  final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();

  Future<void> goToPosition({required double latitude, required double longitude}) async {
    state = MapLoading();
    try{
      final controller = await googleMapController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: await controller.getZoomLevel(),
          )
      )
      );
      state = MapDataFetched();
    }catch(e){
      log(e.toString());
      state = MapError("Error while going to position");
    }

  }

}
