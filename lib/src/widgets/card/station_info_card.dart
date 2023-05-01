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
                          title: Text('Book Slot'),
                          content:
                              Text('Are you sure you want to book this slot?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Booking Confirmed'),
                                    content: Text('Your slot has been booked'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok'))
                                    ],
                                  ),
                                );
                              },
                              child: Text('Confirm'),
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
