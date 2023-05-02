import 'package:eaton_spark/src/globals/colors.dart';
import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 24,
    this.onTap,
    this.size = 80,
    this.isSelected = false,
  });
  final Widget icon;
  final String text;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(1, 4),
              ),
            ],
            gradient: LinearGradient(
              colors: isSelected
                  ? [
                      GlobalColor.secondary.withOpacity(0.8),
                      GlobalColor.secondary,
                    ]
                  : [
                      GlobalColor.primary.withOpacity(0.5),
                      GlobalColor.primary.withOpacity(0.8),
                      GlobalColor.primary,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          width: size,
          height: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: icon,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
