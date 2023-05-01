import 'package:eaton_spark/src/models/home_tabs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  static final HomeTabBloc _instance = HomeTabBloc._internal();
  factory HomeTabBloc() => _instance;

  HomeTabBloc._internal() : super(const HomeTabState()) {
    on<HomeTabChanged>(_onHomeTabChanged);
    _homeTabInitialized();
  }

  _onHomeTabChanged(HomeTabChanged event, Emitter<HomeTabState> emit) async {
    emit(
      state.copyWith(
        mode: _mode,
      ),
    );
  }

  _homeTabInitialized() {
    add(HomeTabChanged());
  }

  static HomeTabMode _mode = HomeTabMode.services;

  void changeHomeTab(int index) {
    _mode = HomeTabMode.values[index];
    add(HomeTabChanged());
  }
}
