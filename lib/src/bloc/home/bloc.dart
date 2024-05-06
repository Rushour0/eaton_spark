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
    print('HomeTabChanged: $_mode');
    if (!_firstLoads[_mode]!) {
      _firstLoads[_mode] = true;
      emit(FirstLoadOfTab(mode: _mode, loaded: true));
      return;
    }
    emit(
      state.copyWith(
        mode: _mode,
        loaded: true,
      ),
    );
  }

  static final Map<HomeTabMode, bool> _firstLoads = {
    HomeTabMode.dashboard: false,
    HomeTabMode.activity: false,
    HomeTabMode.profile: false,
    HomeTabMode.services: false,
  };

  _homeTabInitialized() {
    add(HomeTabChanged());
  }

  static HomeTabMode _mode = HomeTabMode.dashboard;

  void changeHomeTab(int index) {
    _mode = HomeTabMode.values[index];
    add(HomeTabChanged());
  }
}
