// ignore_for_file: use_build_context_synchronously

import 'package:eaton_spark/src/models/authentication.dart';
import 'package:eaton_spark/src/models/breakpoints.dart';
import 'package:eaton_spark/src/screens/auth/reset_password/components/reset_password_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    required this.title,
    required this.successCallback,
    required this.params,
  });

  /// App title or title of the screen
  final String title;

  /// Params passed to the screen
  final String params;

  /// Callback function to be called on successful login
  /// The callback function takes a [Map<String, dynamic>] as an argument which contains the user data
  /// Use this to navigate to the next screen
  final Function() successCallback;
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  void onResetPassword() async {
    Map<String, String> params = {};
    widget.params.split('&').forEach((element) {
      final List<String> param = element.split('=');
      params[param[0]] = param[1];
    });

    try {
      await AuthenticationModel.confirmPasswordReset(
        code: params['code'] ?? '',
        password: passwordController.text,
        passwordAgain: passwordAgainController.text,
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
        content: Text('Password has been reset'),
      ),
    );

    await widget.successCallback();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return ResetPasswordMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        passwordAgainController: passwordController,
        passwordController: passwordController,
        onResetPassword: onResetPassword,
      );
    } else {
      return Container();
    }
  }
}
