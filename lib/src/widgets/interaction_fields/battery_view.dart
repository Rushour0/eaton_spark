import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:eaton_spark/src/widgets/sections/vertical.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BatteryView extends StatelessWidget {
  const BatteryView({super.key});

  static List<Color> _colors = [
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
    return HorizontalSection(
        rightPadding: 0,
        title: 'Battery Status ',
        scrollable: false,
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
                size: Size(100, 200),
                waveAmplitude: 0,
              ),
            ),
          ),
          Expanded(
            child: VerticalSection(
              title: 'Details ',
              scrollable: false,
              rightPadding: 0,
              // overallHeight: 100,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Battery Level:'),
                    Text(' 90%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Battery Health:'),
                    Text(' 78%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Battery Temperature:'),
                    Text(' 27°C'),
                  ],
                ),
                Row(
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
                      backgroundColor: GlobalColor.tertiary,
                    ),
                    onPressed: () {
                      ServicesTabBloc().changeMode(ServicesTabMode.charge_now);
                      HomeTabBloc().changeHomeTab(1);
                    },
                    child: Text('Charge Now!'),
                  ),
                ),
              ],
            ),
          )
        ]);
  }
}
