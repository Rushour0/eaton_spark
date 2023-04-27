// ignore_for_file: use_build_context_synchronously
import 'package:eaton_spark/src/models/authentication.dart';
import 'package:eaton_spark/src/models/breakpoints.dart';
import 'package:eaton_spark/src/screens/auth/forgot_password/components/forgot_password_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
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
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  void onSend() async {
    try {
      await AuthenticationModel.resetPassword(
        email: emailController.text,
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
        content: Text('Password reset link sent to ${emailController.text}'),
      ),
    );
    await widget.successCallback();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return ForgotPasswordMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        emailController: emailController,
        passwordController: passwordController,
        onSend: onSend,
      );
    } else {
      return Container();
    }
  }
}
