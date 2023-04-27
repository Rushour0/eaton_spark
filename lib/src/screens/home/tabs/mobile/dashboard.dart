import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/card/article_card.dart';
import 'package:eaton_spark/src/widgets/card/icon_card.dart';
import 'package:eaton_spark/src/widgets/card/service_card.dart';
import 'package:eaton_spark/src/widgets/sections/grid.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(title: 'Welcome User!'),
            HorizontalSection(
              title: 'Nearby Stations',
              scrollable: true,
              height: 150,
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
                ]),
            GridSection(
              title: 'All Services',
              height: 400,
              children: {
                'Battery Swap': 'assets/images/battery.png',
                'Add EV': 'assets/images/car.png',
                'EV Charge': 'assets/images/charging-station.png',
                'Explore Routes': 'assets/images/route.png',
              }
                  .entries
                  .map(
                    (entry) => ServiceCard(
                      title: entry.key,
                      image: entry.value,
                      onTap: () {},
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Made With Love :) Rushour0',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
