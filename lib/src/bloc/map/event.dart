part of 'bloc.dart';

abstract class GoogleMapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleMapChanged extends GoogleMapEvent {}

class GoogleMapInitializing extends GoogleMapEvent {}

class GoogleMapMarkersAdded extends GoogleMapEvent {}

class GoogleMapSearchStarted extends GoogleMapEvent {}

class GoogleMapRouteMode extends GoogleMapEvent {}

class GoogleMapRouteModeExit extends GoogleMapEvent {}