part of 'bloc.dart';

abstract class GoogleMapState extends Equatable {
  const GoogleMapState({
    this.status = GoogleMapStatus.searching,
  });

  final GoogleMapStatus status;

  @override
  String toString() {
    return '''GoogleMapState { mode: $status }''';
  }

  @override
  List<Object?> get props => [status];
}

class GoogleMapInitial extends GoogleMapState {
  const GoogleMapInitial() : super();
}

class GoogleMapLoaded extends GoogleMapState {
  const GoogleMapLoaded();
}

class GoogleMapMarkersChanged extends GoogleMapState {
  const GoogleMapMarkersChanged({
    required this.markers,
  }) : super();
  final Set<Marker> markers;

  @override
  String toString() {
    return '''GoogleMapMarkersChanged { markers: $markers }''';
  }

  @override
  List<Object?> get props => [markers];
}

class GoogleMapSearching extends GoogleMapState {
  const GoogleMapSearching() : super();
}

class GoogleMapRouteActive extends GoogleMapState {
  const GoogleMapRouteActive({
    required this.polylines,
  }) : super();

  final Set<Polyline> polylines;

  @override
  String toString() {
    return '''GoogleMapRouting { polylines: $polylines }''';
  }

  @override
  List<Object?> get props => [polylines];
}

class GoogleMapRouteModeInactive extends GoogleMapState {
  const GoogleMapRouteModeInactive() : super();
} 

class GoogleMapError extends GoogleMapState {
  const GoogleMapError() : super();
}
