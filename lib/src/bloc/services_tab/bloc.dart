import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ServicesTabBloc extends Bloc<ServicesTabEvent, ServicesTabState> {
  static final ServicesTabBloc _instance = ServicesTabBloc._internal();
  factory ServicesTabBloc() => _instance;

  ServicesTabBloc._internal() : super(const ServicesTabState()) {
    on<ServicesTabStateChanged>(_serviceTabChanged);
    _serviceTabInitialized();
  }

  _serviceTabChanged(
      ServicesTabStateChanged event, Emitter<ServicesTabState> emit) async {
    emit(
      state.copyWith(
        mode: _mode,
      ),
    );
  }

  _serviceTabInitialized() {
    GoogleMapService.mode(mode);
    add(ServicesTabStateChanged());
  }

  static ServicesTabMode _mode = ServicesTabMode.charge_now;

  static ServicesTabMode get mode => _mode;

  void changeMode(ServicesTabMode mode) {
    _mode = mode;

    GoogleMapService.mode(mode);
    add(ServicesTabStateChanged());
  }
}
