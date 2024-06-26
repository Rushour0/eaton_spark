import 'package:equatable/equatable.dart';

enum HomeTabMode { dashboard, services, activity, profile }

class HomeTabModel extends Equatable {
  const HomeTabModel({required this.mode});

  final HomeTabMode mode;

  @override
  List<Object> get props => [mode];
}
