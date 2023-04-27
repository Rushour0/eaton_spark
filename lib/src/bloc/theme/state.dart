part of 'bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.theme = ThemeMode.light,
  });

  final ThemeMode theme;

  ThemeState copyWith({ThemeMode? theme}) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }

  @override
  String toString() {
    return '''ThemeState { theme: $theme }''';
  }

  @override
  List<Object> get props => [theme];
}
