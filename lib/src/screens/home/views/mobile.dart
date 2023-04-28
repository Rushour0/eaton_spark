import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';

import 'package:eaton_spark/src/screens/home/tabs/mobile/dashboard.dart';
import 'package:eaton_spark/src/screens/home/tabs/mobile/stations.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => HomeTabBloc(),
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        buildWhen: (previous, current) {
          return previous.mode != current.mode;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppbar(title: ''),
            extendBodyBehindAppBar: false,
            extendBody: false,
            body: IndexedStack(
              index: state.mode.index,
              children: [
                Dashboard(),
                StationsTab(),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.red,
                ),
                // HomeView(),
                // StationsView(),
                // SearchView(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: GlobalColor.primary,
              currentIndex: state.mode.index,
              onTap: (index) {
                HomeTabBloc().changeHomeTab(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.ev_station),
                  label: 'Stations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
