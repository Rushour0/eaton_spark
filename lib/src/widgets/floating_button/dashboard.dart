import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingButtonDashboard extends StatelessWidget {
  const FloatingButtonDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
          child: Icon(Icons.wifi),
          label: 'Add via WiFi',
          onTap: () {},
        ),
        SpeedDialChild(
          child: Icon(Icons.two_wheeler),
          label: 'Add 2 Wheeler',
          onTap: () {},
        ),
        SpeedDialChild(
          child: const ImageIcon(
            AssetImage(
              'assets/images/car.png',
            ),
          ),
          label: 'Add 4 Wheeler',
          onTap: () {},
        ),
      ],
    );
  }
}
