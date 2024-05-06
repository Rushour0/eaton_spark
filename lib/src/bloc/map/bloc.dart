import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/models/map.dart';
import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'event.dart';
part 'state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  static final GoogleMapBloc _instance = GoogleMapBloc._internal();
  factory GoogleMapBloc() => _instance;

  GoogleMapBloc._internal() : super(const GoogleMapInitial()) {
    on<GoogleMapEvent>(_onMapChanged);
    _mapInitialized();
  }

  void _onMapChanged(GoogleMapEvent event, Emitter<GoogleMapState> emit) async {
    if (event is GoogleMapInitializing) {
      emit(
        const GoogleMapInitial(),
      );
      return;
    } else if (event is GoogleMapSearchStarted) {
      emit(
        const GoogleMapSearching(),
      );
      return;
    } else if (event is GoogleMapMarkersAdded) {
      emit(
        GoogleMapMarkersChanged(
          markers: GoogleMapService.markers,
        ),
      );
      return;
    } else if (event is GoogleMapRouteMode) {
      emit(
        GoogleMapRouteActive(
          polylines: GoogleMapService.polylines,
        ),
      );
      return;
    } else if (event is GoogleMapRouteModeExit) {
      emit(
        const GoogleMapRouteModeInactive(),
      );
    }

    emit(
      const GoogleMapLoaded(),
    );
  }

  void _mapInitialized() async {
    changeMap(
      GoogleMapStatus.loading,
    );
  }

  static GoogleMapStatus _status = GoogleMapStatus.searching;
  static LatLng? _position;

  void addedMarkers() async {
    changeMap(GoogleMapStatus.loaded);
    add(GoogleMapMarkersAdded());
  }

  void activateRoutingMode() {
    add(GoogleMapRouteMode());
  }

  void deactivateRoutingMode() {
    GoogleMapService.clearRoutes();
    add(GoogleMapRouteModeExit());
    GoogleMapService.mode(ServicesTabBloc.mode);
  }

  void changeMap(GoogleMapStatus status) {
    _status = status;
    if (status == GoogleMapStatus.loaded) {
      add(GoogleMapChanged());
    } else if (status == GoogleMapStatus.searching) {
      add(GoogleMapSearchStarted());
    } else if (status == GoogleMapStatus.loading) {
      add(GoogleMapInitializing());
    } else {
      add(GoogleMapChanged());
    }
  }
}
