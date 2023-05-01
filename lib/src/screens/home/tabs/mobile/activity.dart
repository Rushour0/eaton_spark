import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/sections/grid.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:eaton_spark/src/widgets/sections/vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  static final List<Widget> _list = [
    // Cards for past recent activity of charging and swapping
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(
          value: AuthenticationBloc(),
        ),
      ],
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: FloatingActionButton(
            heroTag: 'activity',
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  // MediaQuery.of(context).padding.top
                  kToolbarHeight
              // MediaQuery.of(context).viewInsets.bottom -
              // 100,
              ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  VerticalSection(
                      title: 'Past',
                      overallHeight: 225,
                      // crossAxisCount: 1,
                      // spacing: ,
                      children: _list),
                  VerticalSection(
                      title: 'Upcoming',
                      overallHeight: 225,
                      // crossAxisCount: 1,
                      // spacing: ,
                      children: _list),
                ],
              ),
            ),
          )),
    );
  }
}
