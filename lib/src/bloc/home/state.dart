part of 'bloc.dart';

class HomeTabState extends Equatable {
  const HomeTabState({
    this.mode = HomeTabMode.dashboard,
    this.loaded = false,
  });

  final HomeTabMode mode;
  final bool loaded;

  HomeTabState copyWith({HomeTabMode? mode, bool? loaded}) {
    return HomeTabState(
      mode: mode ?? this.mode,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  String toString() {
    return '''HomeTabState { mode: $mode, loaded: $loaded }''';
  }

  @override
  List<Object> get props => [mode, loaded];
}

class FirstLoadOfTab extends HomeTabState {
  const FirstLoadOfTab({
    required super.mode,
    required super.loaded,
  });

  @override
  String toString() {
    return '''FirstLoadOfTab { mode: $mode, loaded: $loaded }''';
  }

  @override
  List<Object> get props => [mode, loaded];
}
