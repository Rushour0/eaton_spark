part of 'bloc.dart';

class HomeTabState extends Equatable {
  const HomeTabState({
    this.mode = HomeTabMode.dashboard,
  });

  final HomeTabMode mode;

  HomeTabState copyWith({HomeTabMode? mode}) {
    return HomeTabState(
      mode: mode ?? this.mode,
    );
  }

  @override
  String toString() {
    return '''HomeTabState { mode: $mode }''';
  }

  @override
  List<Object> get props => [mode];
}

class FirstLoadOfTab extends HomeTabState {
  const FirstLoadOfTab({
    required super.mode,
  });

  @override
  String toString() {
    return '''FirstLoadOfTab { mode: $mode }''';
  }

  @override
  List<Object> get props => [mode];
}
