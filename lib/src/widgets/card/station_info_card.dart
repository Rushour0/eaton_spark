import 'package:eaton_spark/src/globals/colors.dart';
import 'package:flutter/material.dart';

class StationInfoCard extends StatelessWidget {
  const StationInfoCard({
    super.key,
    this.name = 'Station Name',
    this.address = 'Station Address',
  });
  final String name, address;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        ListTile(
          leading: const Icon(Icons.electric_car_rounded),
          title: Text(name),
          subtitle: Text(address),
          // isThreeLine: true,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: GlobalColor.secondary,
                      ),
                      Text(' 3km away', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.electric_car_rounded,
                        color: GlobalColor.primary,
                      ),
                      Text(' 240V AC', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse_rounded,
                        color: GlobalColor.tertiary,
                      ),
                      Text(' Free in 20mins', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.charging_station_rounded,
                        color: GlobalColor.danger,
                      ),
                      Text(' Type 2', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_rounded,
                        color: GlobalColor.primary,
                      ),
                      Text(' 8 ₹ / kWh', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.webhook_rounded,
                        color: GlobalColor.notice,
                      ),
                      Text(' Tata Power ', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        ButtonBar(
          children: <Widget>[
            TextButton(
              child: const Text('Navigate'),
              onPressed: () {/* ... */},
            ),
            TextButton(
              child: const Text('Book Slot'),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Book Slot'),
                          content:
                              const Text('Are you sure you want to book this slot?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Booking Confirmed'),
                                    content: const Text('Your slot has been booked'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Ok'))
                                    ],
                                  ),
                                );
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        ));
              },
            ),
          ],
        ),
      ]),
    );
  }
}
