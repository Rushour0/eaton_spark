import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/widgets/sections/vertical.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BatteryView extends StatelessWidget {
  const BatteryView({super.key});

  static final List<Color> _colors = [
    // GlobalColor.secondary,
    // GlobalColor.primary.withOpacity(0.9),
    GlobalColor.primary,
  ];

  static const _durations = [
    // 10000,
    5000,
    // 10000,
  ];

  static const _heightPercentages = [
    0.1,
    // 0.11,
    // 0.66,
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return VerticalSection(
        rightPadding: 0,
        title: 'Battery Status ',
        scrollable: false,
        children: [
          Row(
            children: [
              Card(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: WaveWidget(
                    waveFrequency: 1.5,
                    config: CustomConfig(
                      colors: _colors,
                      durations: _durations,
                      heightPercentages: _heightPercentages,
                    ),
                    size: const Size(100, 225),
                    waveAmplitude: 0,
                  ),
                ),
              ),
              // Dropdown with vehicle choosing options
              SizedBox(
                width: screenWidth / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: screenWidth / 2.5,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        // color: GlobalColor.background,
                        border: Border.all(
                          color: GlobalColor.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        elevation: 10,
                        underline: Container(),
                        value: 'Model 3',
                        items: <String>[
                          'Model 3',
                          'Model S',
                          'Model X',
                          'Model Y'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/car-view.png',
                      width: screenWidth / 2.5,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 20),

                    // last charge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Owned By: ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          " ${FirebaseAuth.instance.currentUser!.displayName!}",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // Fast charge enabled
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fast Charge: ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          ' Enabled',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Last Charge: ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          ' 2 days ago',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]
                .map((e) => Padding(padding: const EdgeInsets.all(8), child: e))
                .toList(),
          ),
          VerticalSection(
            title: 'Details ',
            scrollable: false,
            rightPadding: 0,
            // overallHeight: 100,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Battery Level:'),
                  Text(' 90%'),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Battery Health:'),
                  Text(' 78%'),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Battery Temperature:'),
                  Text(' 27°C'),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Battery Voltage:'),
                  Text(' 12.5V'),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // backgroundColor: GlobalColor.tertiary,
                  ),
                  onPressed: () {
                    context
                        .read<ServicesTabBloc>()
                        .changeMode(ServicesTabMode.charge_now);
                    HomeTabBloc().changeHomeTab(1);
                  },
                  child: const Text('Charge Now!'),
                ),
              ),
            ],
          )
        ]);
  }
}
