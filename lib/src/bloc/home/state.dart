part of 'bloc.dart';

class HomeTabState extends Equatable {
  const HomeTabState({
    this.mode = HomeTabMode.home,
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
