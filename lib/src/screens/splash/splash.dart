import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/globals/svg.dart';
import 'package:eaton_spark/src/models/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    Future.delayed(
      Duration(seconds: 2),
      () => handleSplash(context),
    );
    return Scaffold(
      body: Center(
        child: SvgPicture.string(
          GlobalSvg.logoTitleSvg,
          width: screenWidth * 0.75,
        ),
      ),
    );
  }
}

void handleSplash(context) {
  AuthenticationBloc().isLoggedIn
      ? Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (context) => false)
      : Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signin, (context) => false);
}
