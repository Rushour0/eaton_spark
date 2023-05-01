part of 'bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent({this.ev});
  final EV? ev;

  @override
  List<Object?> get props => [ev];
}

class UserEVAdded extends UserEvent {
  @override
  List<Object?> get props => [ev];
}

class UserStateChanged extends UserEvent {}
