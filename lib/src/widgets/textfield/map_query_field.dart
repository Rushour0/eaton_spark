import 'package:eaton_spark/src/globals/colors.dart';
import 'package:flutter/material.dart';

class MapQueryField extends StatelessWidget {
  const MapQueryField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.phone = false,
    this.errorText = '',
    this.errorBool = false,
  });
  final TextEditingController controller;
  final String labelText, errorText;
  final bool obscureText, phone, errorBool;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: phone ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              hintText: labelText,

              // labelText: labelText,
              errorText: errorBool ? errorText : null,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: GlobalColor.primary,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: GlobalColor.primary,
                ),
              ),
            ),
          ),
        ]
            .map((e) => Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                  ),
                  child: e,
                ))
            .toList());
  }
}
