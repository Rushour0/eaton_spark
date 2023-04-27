// ignore_for_file: use_build_context_synchronously

import 'package:eaton_spark/src/models/authentication.dart';
import 'package:eaton_spark/src/models/breakpoints.dart';
import 'package:eaton_spark/src/screens/auth/signin/components/signin_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({
    super.key,
    required this.title,
    required this.successCallback,
  });

  /// App title or title of the screen
  final String title;

  /// Callback function to be called on successful login
  /// The callback function takes a [Map<String, dynamic>] as an argument which contains the user data
  /// Use this to navigate to the next screen
  final Function() successCallback;
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  void onSignin() async {
    try {
      await AuthenticationModel.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed In with ${emailController.text}!'),
      ),
    );
    await widget.successCallback();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return SigninMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        emailController: emailController,
        passwordController: passwordController,
        onSignin: onSignin,
      );
    } else {
      return Container();
    }
  }
}
