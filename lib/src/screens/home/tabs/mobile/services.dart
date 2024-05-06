import 'package:eaton_spark/src/bloc/map/bloc.dart';
import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/map.dart';
import 'package:eaton_spark/src/models/service_tab.dart';

import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/interaction_fields/choose_service.dart';

import 'package:eaton_spark/src/widgets/map/curved_map.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key, this.mode = ServicesTabMode.charge_now});

  final ServicesTabMode mode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoogleMapBloc>.value(
          value: context.read<GoogleMapBloc>(),
        ),
        BlocProvider<ServicesTabBloc>.value(
          value: context.read<ServicesTabBloc>(),
        ),
      ],
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: BlocBuilder<GoogleMapBloc, GoogleMapState>(
            buildWhen: (previous, current) {
          if (current is GoogleMapInitial) {
            return true;
          }
          if (current is GoogleMapRouteActive) {
            return true;
          }
          if (previous is GoogleMapRouteModeInactive) {
            return true;
          }

          return false;
        }, builder: (context, state) {
          if (state is GoogleMapRouteActive) {
            return FloatingActionButton.extended(
              heroTag: 'routing',
              onPressed: () {
                GoogleMapBloc().deactivateRoutingMode();
              },
              label: const Text('Exit Routing Mode'),
              icon: const Icon(Icons.remove_road_rounded),
            );
          }
          return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
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
                ),
              ].map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: e,
                );
              }).toList());
        }),
        body: BlocBuilder<GoogleMapBloc, GoogleMapState>(
            buildWhen: (previous, current) {
          if (current is GoogleMapInitial) {
            return true;
          }
          if (current is GoogleMapMarkersChanged) {
            return true;
          } else if (current is GoogleMapRouteActive) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: (MediaQuery.of(context).size.height - kToolbarHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      CustomAppbar(
                        title: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                text: "How can I be of ",
                                children: [
                                  TextSpan(
                                    text: "service",
                                    style: TextStyle(
                                      color: GlobalColor.primary,
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
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Text(
                            'Services',
                            style: TextStyle(
                              fontSize: 48,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const ChooseService(),
                  const Expanded(child: CurveEdgeMap()),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
