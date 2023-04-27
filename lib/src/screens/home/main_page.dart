import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:eaton_spark/src/models/breakpoints.dart';
import 'package:flutter/material.dart';
import 'views.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    if (screenWidth <= BreakPoints.md.value) {
      return MainMobile();
    } else {
      return Container();
    }
  }
}
