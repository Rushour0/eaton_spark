import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class GlobalColor {
  static ThemeMode? _theme;

  GlobalColor.theme(ThemeMode theme) {
    _theme = theme;
  }

  static const Color primary = Color(0xFF11AA08);

  static const Color secondary = Color(0xFFFFDE59);

  static const Color tertiary = Color(0xFF5544FF);

  static const Color dark = Color(0xFF242424);

  static Color get background => (_theme != null
          ? (_theme == ThemeMode.light)
          : (SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light))
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF14141F);

  static Color get text => (_theme != null
          ? (_theme == ThemeMode.light)
          : (SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light))
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);

  static Color get textFieldBorder => (_theme != null
          ? (_theme == ThemeMode.light)
          : (SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light))
      ? const Color(0xFF1F1F2E)
      : const Color(0xFF555555);

  static Color get textFieldBackground => (_theme != null
          ? (_theme == ThemeMode.light)
          : (SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light))
      ? const Color(0xFFF2F2F7)
      : const Color(0xFF1F1F2E);

  static const Color success = Color(0xFF219653);
  static const Color danger = Color(0xFFEB5757);
  static const Color warning = Color(0xFFF2994A);
  static const Color notice = Color(0xFFF2C94C);
}
