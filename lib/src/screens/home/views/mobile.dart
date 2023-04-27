import 'package:eaton_spark/src/bloc/home/bloc.dart';

import 'package:eaton_spark/src/screens/home/tabs/mobile/dashboard.dart';
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
            extendBodyBehindAppBar: false,
            extendBody: false,

            body: IndexedStack(
              index: state.mode.index,
              children: [
                Dashboard(),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
                // HomeView(),
                // StationsView(),
                // SearchView(),
              ],
            ),

            // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.endDocked,
            // floatingActionButton: Padding(
            //   padding: EdgeInsets.only(bottom: screenHeight * 0.08),
            //   child: CircularMenu(
            //     alignment: Alignment.bottomRight,
            //     toggleButtonColor: GlobalColor.primary,
            //     toggleButtonIconColor: Colors.white,
            //     toggleButtonSize: 36,
            //     toggleButtonBoxShadow: [],
            //     radius: 100,
            //     items: [
            //       CircularMenuItem(
            //           icon: Icons.add,
            //           color: Colors.green,
            //           boxShadow: [],
            //           onTap: () {
            //             //callback
            //           }),
            //       CircularMenuItem(
            //           icon: Icons.schedule,
            //           badgeTextColor: GlobalColor.text,
            //           boxShadow: [],
            //           onTap: () {
            //             //callback
            //           }),
            //       CircularMenuItem(
            //           icon: Icons.pages,
            //           boxShadow: [],
            //           onTap: () {
            //             //callback
            //           }),
            //     ],
            //   ),
            // ),
            
            bottomNavigationBar: BottomNavigationBar(
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
                  icon: Icon(Icons.history),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.ev_station),
                  label: 'Stations',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
