import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:eaton_spark/src/models/appbar.dart';

part 'event.dart';
part 'state.dart';

class CustomAppbarBloc extends Bloc<CustomAppbarEvent, CustomAppbarState> {
  static final CustomAppbarBloc _instance = CustomAppbarBloc._internal();
  factory CustomAppbarBloc() => _instance;

  CustomAppbarBloc._internal() : super(const CustomAppbarState()) {
    on<CustomAppbarChanged>(_onCustomAppbarChanged);
    _customAppbarInitialized();
  }

  _onCustomAppbarChanged(
      CustomAppbarChanged event, Emitter<CustomAppbarState> emit) async {
    emit(
      state.copyWith(
        mode: mode,
        isSearch: isSearch,
      ),
    );
  }

  _customAppbarInitialized() {
    add(CustomAppbarChanged());
  }

  CustomAppbarMode mode = CustomAppbarMode.normal;
  bool isSearch = false;

  void changeCustomAppbar(bool isSearch) {
    mode = isSearch ? CustomAppbarMode.search : CustomAppbarMode.normal;
    this.isSearch = isSearch;
    add(CustomAppbarChanged());
  }
}
