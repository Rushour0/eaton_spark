part of 'bloc.dart';

class GoogleMapState extends Equatable {
  const GoogleMapState({
    this.status = GoogleMapStatus.searching,
  });

  final GoogleMapStatus status;

  GoogleMapState copyWith({GoogleMapStatus? status, LatLng? position}) {
    return GoogleMapState(
      status: status ?? this.status,
    );
  }

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

class GoogleMapSearching extends GoogleMapState {
  const GoogleMapSearching() : super();
}

class GoogleMapError extends GoogleMapState {
  const GoogleMapError() : super();
}
