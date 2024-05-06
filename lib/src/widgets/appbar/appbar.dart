import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  final TextEditingController textController = TextEditingController();
  final Widget title;
  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<ThemeBloc>.value(
      value: ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return AppBar(elevation: 0, title: title, centerTitle: false, actions: [
          IconButton(
            icon: BlocProvider.of<ThemeBloc>(context).isDark
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode, color: Colors.black),
            onPressed: () {
              ThemeBloc().changeTheme(!ThemeBloc().isDark);
            },
          ),
        ]);
      }),
    );
  }
}
