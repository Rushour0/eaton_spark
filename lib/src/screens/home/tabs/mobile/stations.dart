import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/bloc/map/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/map.dart';

import 'package:eaton_spark/src/services/google_maps/maps.dart';

import 'package:eaton_spark/src/widgets/map/curved_map.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationsTab extends StatelessWidget {
  const StationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoogleMapBloc>.value(
          value: GoogleMapBloc(),
        ),
        BlocProvider<AuthenticationBloc>.value(
          value: AuthenticationBloc(),
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state.isLoggedIn) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            text: "Where to ",
                            children: [
                              TextSpan(
                                text: "charge",
                                style: TextStyle(
                                  color: GlobalColor.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }
                  return const Text('You are not logged in');
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Stations',
                        style: TextStyle(
                          fontSize: 48,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await GoogleMapService.stationsNearby();
                        },
                        icon: const Icon(Icons.ev_station),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: BlocBuilder<GoogleMapBloc, GoogleMapState>(
            buildWhen: (previous, current) {
          if (previous is GoogleMapInitial) {
            return true;
          }

          return false;
        }, builder: (context, state) {
          return FloatingActionButton(
            heroTag: 'stations',
            onPressed: () {
              BlocProvider.of<GoogleMapBloc>(context)
                  .changeMap(GoogleMapStatus.loading);
              GoogleMapService.currentLatLng().then((value) {
                GoogleMapService.controller!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: value,
                      zoom: 15,
                    ),
                  ),
                );
                BlocProvider.of<GoogleMapBloc>(context)
                    .changeMap(GoogleMapStatus.loaded);
              });
            },
            child: const Icon(Icons.my_location),
          );
        }),
        body: BlocBuilder<GoogleMapBloc, GoogleMapState>(
            buildWhen: (previous, current) {
          if (previous is GoogleMapMarkersChanged) {
            return true;
          } else if (current is GoogleMapRouteActive) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          return CurveEdgeMap();
        }),
      ),
    );
  }
}
