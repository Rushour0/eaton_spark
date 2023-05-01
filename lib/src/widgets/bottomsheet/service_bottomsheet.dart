import 'package:flutter/material.dart';

class ServicesBottomSheet extends StatelessWidget {
  const ServicesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 200,
            color: Colors.red,
          );
        });
  }
}
