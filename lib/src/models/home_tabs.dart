import 'package:equatable/equatable.dart';

enum HomeTabMode { home, stations, activity, profile }

class HomeTabModel extends Equatable {
  const HomeTabModel({required this.mode, required this.isSearch});

  final HomeTabMode mode;
  final bool isSearch;
  @override
  List<Object> get props => [mode];
}
