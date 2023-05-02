import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/home_tabs.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/sections/grid.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:eaton_spark/src/widgets/sections/vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  static final List<Widget> _ulist = [
    // Cards for past recent activity of charging and swapping
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
            child: Text('Model Y Tesla'),
          ),
          ListTile(
            leading: Icon(Icons.charging_station),
            title: Text('Scheduled Charge'),
            subtitle: Text('in 10 hours'),
            trailing: Text(
              '₹ 140',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
    Divider(),
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
            child: Text('Model X Tesla'),
          ),
          ListTile(
            leading: Icon(Icons.swap_horiz_sharp),
            title: Text('Battery Swap'),
            subtitle: Text('in 25 hours'),
            trailing: Text(
              '₹ 100',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  static final List<Widget> _list = [
    // Cards for past recent activity of charging and swapping
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
            child: Text('Model 3 Tesla'),
          ),
          ListTile(
            leading: Icon(Icons.charging_station),
            title: Text('Charged'),
            subtitle: Text('23 hours ago'),
            trailing: Text(
              '₹ 140',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
    Divider(),
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
            child: Text('Model S Tesla'),
          ),
          ListTile(
            leading: Icon(Icons.swap_horiz_sharp),
            title: Text('Battery Swap'),
            subtitle: Text('23 hours ago'),
            trailing: Text(
              '₹ 100',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
    Divider(),
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
            child: Text('Model X Tesla'),
          ),
          ListTile(
            leading: Icon(Icons.charging_station),
            title: Text('Charged'),
            subtitle: Text('23 hours ago'),
            trailing: Text(
              '₹ 140',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  static List<Widget> _content = [Container()];

  void builder() {
    _content = [
      PlayAnimationBuilder<double>(
          tween: Tween(begin: 0.4, end: 1.0),
          duration: Duration(seconds: 3),
          curve: Curves.fastOutSlowIn,
          builder: (context, value, child) {
            return VerticalSection(
                title: 'Upcoming',
                overallHeight: 225 * value,
                // crossAxisCount: 1,
                // spacing: ,
                children: _ulist);
          }),
      PlayAnimationBuilder<double>(
          tween: Tween(begin: 0.4, end: 1.0),
          duration: Duration(seconds: 3),
          curve: Curves.fastOutSlowIn,
          builder: (context, value, child) {
            return VerticalSection(
                title: 'Past',
                overallHeight: 225 * value,
                // crossAxisCount: 1,
                // spacing: ,
                children: _list);
          })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<HomeTabBloc>(),
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
          buildWhen: (previous, current) {
        if (current is FirstLoadOfTab && current.mode == HomeTabMode.activity) {
          builder();
          return true;
        }
        return false;
      }, builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                      Column(
                        children: [
                          CustomAppbar(
                            title: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text.rich(
                                  TextSpan(
                                    text: "What have you been ",
                                    children: [
                                      TextSpan(
                                        text: "upto",
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                              child: Text(
                                'Activity',
                                style: TextStyle(
                                  fontSize: 48,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] +
                    _content,
              ),
            ),
          ),
        );
      }),
    );
  }
}
