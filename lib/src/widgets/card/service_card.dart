import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    this.side = 100,
    this.title = 'Service Card',
    required this.image,
    this.onTap,
  });

  final double side;
  final String title;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
            width: side,
            height: side,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            )),
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ].map((e) => Padding(padding: const EdgeInsets.only(top: 8), child: e)).toList());
  }
}
