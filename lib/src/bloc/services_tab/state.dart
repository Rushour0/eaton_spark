part of 'bloc.dart';

class ServicesTabState extends Equatable {
  const ServicesTabState({
    this.mode = ServicesTabMode.charge_now,
  });

  final ServicesTabMode mode;

  ServicesTabState copyWith({ServicesTabMode? mode}) {
    return ServicesTabState(
      mode: mode ?? this.mode,
    );
  }

  @override
  String toString() {
    return '''ServicesTabState { mode: $mode }''';
  }

  @override
  List<Object> get props => [mode];
}
