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

  GoogleMapBloc._internal() : super(const GoogleMapState()) {
    on<GoogleMapChanged>(_onMapChanged);
    _mapInitialized();
  }

  void _onMapChanged(
      GoogleMapChanged event, Emitter<GoogleMapState> emit) async {
    if (event is GoogleMapLoaded) {
      emit(state.copyWith(
        status: _status,
        position: _position,
      ));
      return;
    }

    emit(
      state.copyWith(
        status: _status,
      ),
    );
  }

  void _mapInitialized() async {
    changeMap(GoogleMapStatus.loading);

    GoogleMapService.currentLatLng().then((value) {
      GoogleMapService.controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: value,
            zoom: 15,
          ),
        ),
      );
      changeMap(
        GoogleMapStatus.loaded,
      );
    });
  }

  static GoogleMapStatus _status = GoogleMapStatus.searching;
  static LatLng? _position;

  void changeMap(GoogleMapStatus status) {
    _status = status;

    add(GoogleMapChanged());
  }
}
