import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GoogleMapStatus { loading, searching, loaded }

class MapModel extends Equatable {
  const MapModel({required this.status, required this.position});

  final GoogleMapStatus status;
  final LatLng position;

  @override
  List<Object> get props => [status, position];
}
