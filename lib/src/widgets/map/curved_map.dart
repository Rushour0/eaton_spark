import 'package:eaton_spark/src/bloc/map/bloc.dart';
import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurveEdgeMap extends StatelessWidget {
  const CurveEdgeMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapBloc, GoogleMapState>(
      listener: (context, state) {
        if (state is GoogleMapRouteActive) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Routing mode activated'),
            ),
          );
        }
        if (state is GoogleMapRouteModeInactive) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Routing mode deactivated'),
            ),
          );
        }
        if (state is GoogleMapSearching) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Searching for location'),
            ),
          );
        }

        if (state is GoogleMapLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Map loaded'),
            ),
          );
        }

        if (state is GoogleMapInitial) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Map initializing'),
            ),
          );
        }

        if (state is GoogleMapMarkersChanged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Markers updated'),
            ),
          );
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: GoogleMap(
            polylines: GoogleMapService.polylines,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            buildingsEnabled: true,
            markers: GoogleMapService.markers,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 0,
            ),
            onMapCreated: (GoogleMapController controller) {
              GoogleMapService.controller = controller;
            },
          ),
        );
      },
    );
  }
}
