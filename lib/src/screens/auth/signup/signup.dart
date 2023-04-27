// ignore_for_file: use_build_context_synchronously

import 'package:eaton_spark/src/models/authentication.dart';
import 'package:eaton_spark/src/models/breakpoints.dart';
import 'package:eaton_spark/src/screens/auth/signup/components/signup_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({
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
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();
  void onSignup() async {
    try {
      await AuthenticationModel.signUp(
        name: nameController.text,
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
        content:
            Text('Email Verification link sent to ${emailController.text}'),
      ),
    );
    await widget.successCallback();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return SignupMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        onSignup: onSignup,
      );
    } else if (screenWidth < BreakPoints.lg.value) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.blue,
              ),
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.blue,
              ),
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }
  }
}
