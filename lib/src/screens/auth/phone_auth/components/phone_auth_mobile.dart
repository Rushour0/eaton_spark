import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/routes.dart';
import 'package:eaton_spark/src/widgets/button/button.dart';
import 'package:eaton_spark/src/widgets/textfield/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PhoneAuthMobile extends StatelessWidget {
  const PhoneAuthMobile({
    super.key,
    required this.title,
    required this.successCallback,
    required this.phoneNumberController,
    required this.onSend,
  });

  final String title;

  final Function() successCallback;
  final Function() onSend;

  final TextEditingController phoneNumberController;

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
                                'Phone Auth',
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
                      controller: phoneNumberController,
                      labelText: 'Phone Number',
                      phone: true,
                    ),
                  ],
                ),
                Column(
                    children: [
                  GenericElevatedButton(
                    text: 'Send OTP',
                    onPressed: onSend,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Want to login with email ? ',
                          style: TextStyle(
                            color: GlobalColor.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await Navigator.pushNamedAndRemoveUntil(
                                  context, AppRoutes.signin, (route) => false);
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
