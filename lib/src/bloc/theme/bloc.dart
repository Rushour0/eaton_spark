import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'event.dart';
part 'state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static final ThemeBloc _instance = ThemeBloc._internal();
  factory ThemeBloc() => _instance;

  ThemeBloc._internal() : super(const ThemeState()) {
    on<ThemeChanged>(_onThemeChanged);
    _themeInitialized();
  }

  _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(
      theme: _theme ??
          (SchedulerBinding.instance.window.platformBrightness ==
                  Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark),
    ));
  }

  _themeInitialized() {
    add(ThemeChanged());
  }

  bool get isDark => state.theme == ThemeMode.dark;
  ThemeMode? _theme;

  void changeTheme(bool isDark) {
    _theme = isDark ? ThemeMode.dark : ThemeMode.light;

    add(ThemeChanged());
  }
}
