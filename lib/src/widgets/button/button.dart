import 'package:eaton_spark/src/globals/colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class GenericElevatedButton extends StatelessWidget {
  const GenericElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return PlayAnimationBuilder(
      tween: Tween(begin: 0.5, end: 1.0),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      builder: (context, value, child) => SizedBox(
        width: MediaQuery.of(context).size.width * value * 0.9,
        height: screenHeight * 0.06,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
