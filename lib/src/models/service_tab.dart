import 'package:equatable/equatable.dart';

enum ServicesTabMode {
  map,
  charge_now,
  explore_route,
  battery_swap,
  plan_charge
}

extension Title on ServicesTabMode {
  String get title {
    return name
        .split('_')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .toList()
        .join(' ');
  }
}

class ServicesTabModel extends Equatable {
  const ServicesTabModel({required this.mode});

  final ServicesTabMode mode;

  @override
  List<Object> get props => [mode];
}
