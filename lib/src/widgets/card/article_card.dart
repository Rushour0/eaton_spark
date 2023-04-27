import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
    this.imageHeight = 100,
    this.imageWidth = 150,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;
  final double imageHeight, imageWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
