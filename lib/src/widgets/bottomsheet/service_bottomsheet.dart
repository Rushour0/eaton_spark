import 'package:eaton_spark/src/widgets/card/station_info_card.dart';
import 'package:flutter/material.dart';

class ServicesTabBottomSheet extends StatelessWidget {
  const ServicesTabBottomSheet({super.key});

  static final _stations = [
    {
      "name": "Prakriti EV Charging Station",
      "address": "Kalyani Nagar, Pune, Maharashtra"
    },
    {
      "name": "Samarthya EV Charging Station",
      "address": "Baner, Pune, Maharashtra"
    },
    {
      "name": "Urjavikas EV Charging Station",
      "address": "Viman Nagar, Pune, Maharashtra"
    },
    {
      "name": "Vidyut EV Charging Station",
      "address": "Kothrud, Pune, Maharashtra"
    },
    {
      "name": "Tatva EV Charging Station",
      "address": "Kharadi, Pune, Maharashtra"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.1,
      builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            child: Column(
              children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Divider(
                            thickness: 5,
                            indent: 150,
                            endIndent: 150,
                          ),
                          Text(
                            'Choose Station',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ] +
                  _stations
                      .map(
                        (station) => StationInfoCard(
                          name: station['name']!,
                          address: station['address']!,
                        ),
                      )
                      .toList(),
            ),
          )),
    );
  }
}
