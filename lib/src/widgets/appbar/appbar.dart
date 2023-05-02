import 'package:eaton_spark/src/bloc/appbar/bloc.dart';
import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/widgets/searchbar/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({Key? key, required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final TextEditingController textController = TextEditingController();
  final Widget title;
  @override
  final Size preferredSize; // default is 56.0

  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<ThemeBloc>.value(
      value: ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return AppBar(elevation: 0, title: title, centerTitle: false, actions: [
          IconButton(
            icon: BlocProvider.of<ThemeBloc>(context).isDark
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode, color: Colors.black),
            onPressed: () {
              ThemeBloc().changeTheme(!ThemeBloc().isDark);
            },
          ),
        ]);
      }),
    );
  }
}
