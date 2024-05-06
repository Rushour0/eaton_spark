import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/bloc/map/bloc.dart';
import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/screens/home/tabs/mobile/activity.dart';

import 'package:eaton_spark/src/screens/home/tabs/mobile/dashboard.dart';
import 'package:eaton_spark/src/screens/home/tabs/mobile/profile.dart';
import 'package:eaton_spark/src/screens/home/tabs/mobile/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeTabBloc>.value(
          value: HomeTabBloc(),
        ),
        BlocProvider<ServicesTabBloc>.value(
          value: ServicesTabBloc(),
        ),
        BlocProvider<GoogleMapBloc>.value(
          value: GoogleMapBloc(),
        ),
        BlocProvider<AuthenticationBloc>.value(
          value: AuthenticationBloc(),
        ),
        BlocProvider<ThemeBloc>.value(
          value: ThemeBloc(),
        ),
      ],
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        buildWhen: (previous, current) {
          return previous.mode != current.mode;
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            // backgroundColor: GlobalColor.background,
            extendBody: false,
            body: IndexedStack(
              index: state.mode.index,
              children: const [
                Dashboard(),
                ServicesTab(),
                ActivityTab(),
                ProfileTab(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: GlobalColor.primary,
              currentIndex: state.mode.index,
              onTap: (index) {
                HomeTabBloc().changeHomeTab(index);
              },
              items: const [
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
