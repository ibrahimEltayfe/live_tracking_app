import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/features/map/presentation/provider/client_location_provider/client_location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error_handling/failures.dart';
import '../../../../core/shared/models/client_location_model.dart';
import '../provider/map_provider/map_provider.dart';

class MapPage extends ConsumerStatefulWidget {
  final String locationId;
  const MapPage(this.locationId, {Key? key}) : super(key: key);

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _BuildClientTrackingMap(locationId: widget.locationId,),
      ),
    );
  }
}

class _BuildClientTrackingMap extends StatelessWidget {
  final String locationId;
  const _BuildClientTrackingMap({Key? key, required this.locationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (_,ref,child) {
          final mapState = ref.watch(mapProvider);
          final mapRef = ref.watch(mapProvider.notifier);

          final clientLocationRef = ref.watch(clientLocationProvider(locationId));

          ref.listen(clientLocationProvider(locationId), (previous, current) {
            if(current.hasError){
              final Failure error = current.value as Failure;
              Fluttertoast.showToast(msg: error.message);//todo:add error style
            }else if(current.hasValue){
              final ClientLocationModel? locationModel = current.value as ClientLocationModel?;

              if(locationModel != null && locationModel.lat != null && locationModel.lon != null){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  mapRef.goToPosition(
                    latitude: locationModel.lat!,
                    longitude: locationModel.lon!
                  );
                });
              }

            }
          });

          return Stack(
            children: [
              clientLocationRef.whenData(
                  (value) {
                    final ClientLocationModel? locationModel = value as ClientLocationModel?;

                    if(locationModel == null || locationModel.lat == null || locationModel.lon == null){
                      return const Center(
                        child: Text('no live data available.'),
                      );
                    }

                    final currentCameraPosition = CameraPosition(
                      target: LatLng(
                         locationModel.lat!,
                         locationModel.lon!
                      ),
                      zoom: 16
                    );

                    return GoogleMap(
                      mapType: MapType.hybrid,
                      markers:{
                        Marker(
                          position:LatLng(
                              locationModel.lat!,
                              locationModel.lon!
                          ),
                          markerId: MarkerId(''),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                        )
                      },
                      initialCameraPosition: currentCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        log('on map created');

                        if(!mapRef.googleMapController.isCompleted){
                          log('complete');
                          mapRef.googleMapController.complete(controller);
                        }

                      },
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                    );
                  },
              ).value ?? SizedBox.shrink(),

              if(mapState is MapLoading || clientLocationRef.isLoading)
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  child: const _BuildLoadingWidget(),
                ),

            ],
          );


        }
    );
  }
}

class _BuildLoadingWidget extends StatelessWidget {
  const _BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white,
        ),
        child: const FractionallySizedBox(
          widthFactor: 0.45,
          heightFactor: 0.45,
          child: FittedBox(
              child: CircularProgressIndicator(color: Colors.black,)
          ),
        )
    );
  }
}

