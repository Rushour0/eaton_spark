import 'package:flutter/material.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'Coming soon!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text('Activity Tab'), Text('Coming soon!')],
        ),
      ),
    );
  }
}
