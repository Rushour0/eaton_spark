import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

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
          children: [Text('Profile Tab'), Text('Coming soon!')],
        ),
      ),
    );
  }
}
