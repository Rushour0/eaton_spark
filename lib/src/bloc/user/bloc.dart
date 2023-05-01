import 'package:eaton_spark/src/models/ev.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static final UserBloc _instance = UserBloc._internal();
  factory UserBloc() => _instance;

  UserBloc._internal() : super(const UserState()) {
    on<UserStateChanged>(_serviceChanged);
  }

  _serviceChanged(UserStateChanged event, Emitter<UserState> emit) async {
    emit(UserState());
  }

  void receiveEvent(UserEvent event) {
    add(UserStateChanged());
  }
}
