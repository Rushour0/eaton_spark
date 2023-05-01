part of 'bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.mode = ServicesTabMode.charge_now,
  });

  final ServicesTabMode mode;

  UserState copyWith({ServicesTabMode? mode}) {
    return UserState(
      mode: mode ?? this.mode,
    );
  }

  @override
  String toString() {
    return '''UserState { mode: $mode }''';
  }

  @override
  List<Object> get props => [mode];
}
