import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingButtonDashboard extends StatelessWidget {
  const FloatingButtonDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(icon: Icons.menu, activeIcon: Icons.close, children: [
      SpeedDialChild(
        child: const ImageIcon(
          AssetImage(
            'assets/images/battery.png',
          ),
        ),
        label: 'Battery Swap',
        onTap: () {},
      ),
      SpeedDialChild(
        child: const ImageIcon(
          AssetImage(
            'assets/images/car.png',
          ),
        ),
        label: 'Add EV',
        onTap: () {},
      ),
      SpeedDialChild(
        child: const ImageIcon(
          AssetImage(
            'assets/images/route.png',
          ),
        ),
        label: 'Explore Route',
        onTap: () {},
      ),
      SpeedDialChild(
        child: const ImageIcon(
          AssetImage(
            'assets/images/charging-station.png',
          ),
        ),
        label: 'EV Charge',
        onTap: () {},
      )
    ]);
  }
}
