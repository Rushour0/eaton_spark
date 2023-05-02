import 'package:eaton_spark/src/globals/colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class GenericTextField extends StatefulWidget {
  const GenericTextField({
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
  State<GenericTextField> createState() => GenericTextFieldState();
}

class GenericTextFieldState extends State<GenericTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return PlayAnimationBuilder<double>(
        tween: Tween(begin: 0.5, end: 1.0),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        builder: (context, value, child) {
          return SizedBox(
            width: screenWidth * value * 0.9,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.labelText,
                    style: TextStyle(
                      color: GlobalColor.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextFormField(
                    controller: widget.controller,
                    obscureText: obscureText,
                    keyboardType:
                        widget.phone ? TextInputType.phone : TextInputType.text,
                    style: TextStyle(
                      color: GlobalColor.text,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.labelText,
                      hintStyle: TextStyle(
                        color: GlobalColor.textFieldBorder,
                      ),
                      // labelText: widget.labelText,
                      errorText: widget.errorBool ? widget.errorText : null,
                      suffixIcon: widget.obscureText
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: GlobalColor.textFieldBorder,
                              ),
                            )
                          : null,
                      fillColor: GlobalColor.textFieldBorder,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: GlobalColor.textFieldBorder,
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
                            top: screenHeight * 0.015,
                          ),
                          child: e,
                        ))
                    .toList()),
          );
        });
  }
}
