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

class GoogleMapError extends GoogleMapState {
  const GoogleMapError() : super();
}
