import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/routes.dart';
import 'package:eaton_spark/src/widgets/button/button.dart';
import 'package:eaton_spark/src/widgets/textfield/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({
    super.key,
    required this.title,
    required this.successCallback,
    required this.passwordAgainController,
    required this.passwordController,
    required this.onResetPassword,
  });

  final String title;

  final Function() successCallback;
  final Function() onResetPassword;

  final TextEditingController passwordAgainController, passwordController;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final EdgeInsets screenPadding = MediaQuery.of(context).padding;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: GlobalColor.background,
      body: Padding(
        padding: EdgeInsets.only(
          top: screenPadding.top,
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.1,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SvgPicture.string(
                          //   appwriteSvgString,
                          //   width: screenWidth * 0.3,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  color: GlobalColor.text,
                                  fontSize: screenHeight * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Reset Password',
                                style: TextStyle(
                                  color: GlobalColor.text.withAlpha(192),
                                  fontSize: screenHeight * 0.035,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ]
                            .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: screenHeight * 0.05),
                                child: e))
                            .toList()),
                  ),
                ),
                Column(
                  children: [
                    GenericTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    GenericTextField(
                      controller: passwordAgainController,
                      labelText: 'Password Confirmation',
                      obscureText: true,
                      errorText: 'Passwords do not match',
                      errorBool: passwordAgainController.text !=
                          passwordController.text,
                    ),
                  ],
                ),
                Column(
                    children: [
                  GenericElevatedButton(
                    text: 'Reset Password',
                    onPressed: (passwordController.text !=
                                passwordAgainController.text ||
                            passwordController.text == '')
                        ? null
                        : onResetPassword,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sign In ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await Navigator.pushNamedAndRemoveUntil(
                                  context, AppRoutes.signup, (route) => false);
                            },
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: GlobalColor.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: '  |  ',
                          style: TextStyle(
                            color: GlobalColor.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await Navigator.pushNamedAndRemoveUntil(
                                  context, AppRoutes.signup, (route) => false);
                            },
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: GlobalColor.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      ],
                    ),
                  ),
                ]
                        .map((e) => Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.025,
                              // bottom: screenHeight * 0.025,
                            ),
                            child: e))
                        .toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
