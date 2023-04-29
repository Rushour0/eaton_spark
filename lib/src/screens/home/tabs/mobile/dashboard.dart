import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/card/article_card.dart';
import 'package:eaton_spark/src/widgets/card/icon_card.dart';
import 'package:eaton_spark/src/widgets/floating_button/dashboard.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocProvider.value(
                value: AuthenticationBloc(),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state.isLoggedIn) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome ${FirebaseAuth.instance.currentUser!.displayName}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }
                    return Text('You are not logged in');
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text.rich(
                  TextSpan(
                    text: 'Find Your ',
                    children: [
                      TextSpan(
                        text: 'Charge',
                        style: TextStyle(
                          color: GlobalColor.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '⚡',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 72,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 72,
                  ),
                ),
              ),
              HorizontalSection(
                verticalPadding: 24,
                height: 70,
                title: 'Suggestions',
                scrollable: false,
                children: [
                  IconCard(
                    icon: Icons.ev_station,
                    text: 'Charging',
                    size: 70,
                  ),
                  IconCard(
                    icon: Icons.add_road,
                    text: 'Plan Trip',
                    size: 70,
                  ),
                  IconCard(
                    icon: Icons.location_city,
                    text: 'City Maps',
                    size: 70,
                  ),
                  IconCard(
                    icon: Icons.add_location_alt,
                    text: 'Location',
                    size: 70,
                  ),
                ],
              ),
              HorizontalSection(
                title: 'Nearby Stations',
                scrollable: true,
                height: 175,
                verticalPadding: 24,
                rightPadding: 24,
                children: [
                  'assets/images/stations.jpeg',
                  'assets/images/ambient-car-charge.jpeg',
                  'assets/images/car-charge.jpeg',
                ]
                    .map(
                      (image) => ArticleCard(
                        title: 'EV Charge',
                        subtitle: 'Stations',
                        image: image,
                        onTap: () {},
                      ),
                    )
                    .toList(),
              ),
              HorizontalSection(
                title: 'About Us',
                scrollable: true,
                height: 175,
                verticalPadding: 24,
                rightPadding: 24,
                children: [
                  'assets/images/car-charge.jpeg',
                  'assets/images/ambient-car-charge.jpeg',
                  'assets/images/stations.jpeg',
                ]
                    .map(
                      (image) => ArticleCard(
                        title: 'EV Charge',
                        subtitle: 'Stations',
                        image: image,
                        onTap: () {},
                      ),
                    )
                    .toList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8.0),
                  child: Text(
                    'Made With Love :) Rushour0',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingButtonDashboard(),
    );
  }
}
