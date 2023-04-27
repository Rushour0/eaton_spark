// ignore_for_file: use_build_context_synchronously

import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/models/authentication.dart';
import 'package:eaton_spark/src/models/breakpoints.dart';
import 'package:eaton_spark/src/screens/auth/phone_auth/components/phone_auth_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppwritePhoneAuth extends StatefulWidget {
  const AppwritePhoneAuth({
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
  State<AppwritePhoneAuth> createState() => _AppwritePhoneAuthState();
}

class _AppwritePhoneAuthState extends State<AppwritePhoneAuth> {
  final TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();

  void onPhoneSignin() async {
    try {
      // await AuthenticationModel.phoneSignin(
      //   phone: phoneNumberController.text,
      // );
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
        content: Text('OTP sent to ${phoneNumberController.text}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return PhoneAuthMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        phoneNumberController: phoneNumberController,
        onSend: onPhoneSignin,
      );
    } else {
      return Container();
    }
  }
}
