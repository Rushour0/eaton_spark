import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurveEdgeMap extends StatelessWidget {
  const CurveEdgeMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        buildingsEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
        ),
        onMapCreated: (GoogleMapController controller) {
          GoogleMapService.controller = controller;
        },
      ),
    );
  }
}
