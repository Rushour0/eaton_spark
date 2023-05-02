import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/card/article_card.dart';
import 'package:eaton_spark/src/widgets/card/icon_card.dart';
import 'package:eaton_spark/src/widgets/floating_button/dashboard.dart';
import 'package:eaton_spark/src/widgets/interaction_fields/battery_view.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'dart:math' as math;

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static const _options = {
    ServicesTabMode.charge_now: ImageIcon(
      AssetImage('assets/images/charging-station.png'),
    ),
    ServicesTabMode.intercity: ImageIcon(
      AssetImage('assets/images/route.png'),
    ),
    ServicesTabMode.battery_swap: ImageIcon(
      AssetImage('assets/images/battery.png'),
    ),
    ServicesTabMode.plan_charge: Icon(Icons.calendar_month),
  };

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomAppbar(
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      text: 'Welcome ',
                      children: [
                        TextSpan(
                          text: FirebaseAuth.instance.currentUser!.displayName,
                          style: TextStyle(
                            color: GlobalColor.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '!',
                          style: TextStyle(
                            // color: GlobalColor.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
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
                title: 'Services',
                scrollable: false,
                children: _options.entries
                    .map(
                      (e) => CustomAnimationBuilder<double>(
                        control: Control.play,
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 500),
                        delay: Duration(milliseconds: e.key.index * 300),
                        curve: Curves.linear,
                        builder: (context, value, child) => Transform.translate(
                          offset: Offset(0, -math.sin(value * math.pi) * 10),
                          child: IconCard(
                            size: 70,
                            icon: e.value,
                            text: e.key.title,
                            onTap: () {
                              ServicesTabBloc().changeMode(e.key);
                              HomeTabBloc().changeHomeTab(1);
                            },
                          ),
                        ),
                      ),
                    )
                    .toList()),
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
                      title: 'EV Charge Station',
                      subtitle: 'Stations',
                      image: image,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
            BatteryView(),
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
                      title: 'EV Charge Station',
                      subtitle: 'Stations',
                      image: image,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: PlayAnimationBuilder<double>(
          onCompleted: () {
            print('completed');
          },
          tween: Tween<double>(begin: 1, end: 0),
          duration: Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.8 * value),
              child: const FloatingButtonDashboard(),
            );
          }),
    );
  }
}
