part of 'bloc.dart';

class CustomAppbarState extends Equatable {
  const CustomAppbarState({
    this.mode = CustomAppbarMode.normal,
    this.isSearch = false,
  });

  final CustomAppbarMode mode;
  final bool isSearch;

  CustomAppbarState copyWith({CustomAppbarMode? mode, bool? isSearch}) {
    return CustomAppbarState(
      mode: mode ?? this.mode,
      isSearch: isSearch ?? this.isSearch,
    );
  }

  @override
  String toString() {
    return '''CustomAppbarState { mode: $mode, isSearch: $isSearch }''';
  }

  @override
  List<Object> get props => [mode, isSearch];
}
