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

  static final _about = [
    {
      "name": "Eaton Corporation",
      "info":
          "Making of Eaton Corporation, a power management company, dedicated to improving the quality of life and the environment through the use of power management technologies and services. Eaton has approximately 95,000 employees and sells products to customers in more than 175 countries.",
      "image": "assets/images/eaton-logo.jpg",
    },
    {
      "name": "Eaton X Bae Systems",
      "info":
          "Eaton and BAE Systems, two global leaders in the field of power management and vehicle technology, have collaborated to develop electric trucks. The collaboration aims to create a more sustainable transportation system and reduce greenhouse gas emissions.",
      "image": "assets/images/eaton-bae-truck.jpg",
    },
    {
      "name": "Eaton X Charge",
      "info":
          "Eaton and Charge have teamed up to create electric vehicle (EV) charging infrastructure that's faster and easier to deploy. The partnership combines Charge's expertise in EV charging with Eaton's power management solutions, creating an all-in-one system that's modular, scalable, and can be easily deployed in a wide range of locations.",
      "image": "assets/images/eaton-charge-report.jpg",
    },
  ];

  static final _stations = [
    {
      "name": "Prakriti EV Charging Station",
      "address": "Kalyani Nagar, Pune, Maharashtra",
      "image": "assets/images/station1.jpg"
    },
    {
      "name": "Samarthya EV Charging Station",
      "address": "Baner, Pune, Maharashtra",
      "image": "assets/images/station2.jpg"
    },
    {
      "name": "Urjavikas EV Charging Station",
      "address": "Viman Nagar, Pune, Maharashtra",
      "image": "assets/images/station3.jpg"
    },
    {
      "name": "Vidyut EV Charging Station",
      "address": "Kothrud, Pune, Maharashtra",
      "image": "assets/images/station4.jpg"
    },
    {
      "name": "Tatva EV Charging Station",
      "address": "Kharadi, Pune, Maharashtra",
      "image": "assets/images/station5.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final double screenWidth = MediaQuery.of(context).size.width;

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
                            color: GlobalColor.primary,
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
                verticalPadding: screenHeight * 0.03,
                height: screenHeight * 0.3,
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
                            size: screenWidth * 0.2 * value,
                            icon: e.value,
                            text: e.key.title,
                            onTap: () {
                              context.read<ServicesTabBloc>().changeMode(e.key);
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
              height: screenHeight * 0.3,
              verticalPadding: screenHeight * 0.03,
              rightPadding: screenWidth * 0.03,
              children: _stations
                  .map(
                    (station) => ArticleCard(
                      title: station['name']!,
                      subtitle: station['address']!,
                      image: station['image']!,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
            BatteryView(),
            HorizontalSection(
              title: 'About Us',
              scrollable: true,
              height: screenHeight * 0.3,
              verticalPadding: screenHeight * 0.05,
              rightPadding: screenWidth * 0.05,
              children: _about
                  .map(
                    (data) => ArticleCard(
                      title: data['name']!,
                      subtitle: data['info']!,
                      image: data['image']!,
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
