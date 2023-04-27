import 'package:equatable/equatable.dart';

enum CustomAppbarMode { search, normal }

class CustomAppbarModel extends Equatable {
  const CustomAppbarModel({required this.mode, required this.isSearch});

  final CustomAppbarMode mode;
  final bool isSearch;
  @override
  List<Object> get props => [mode, isSearch];
}
