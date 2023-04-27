import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/routes.dart';
import 'package:eaton_spark/src/screens/auth/forgot_password/components/forgot_password_mobile.dart';
import 'package:eaton_spark/src/screens/auth/forgot_password/forgot_password.dart';
import 'package:eaton_spark/src/screens/auth/reset_password/reset_password.dart';
import 'package:eaton_spark/src/screens/auth/signin/signin.dart';
import 'package:eaton_spark/src/screens/auth/signup/signup.dart';
import 'package:eaton_spark/src/screens/common/not_found.dart';
import 'package:eaton_spark/src/screens/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});
  static const _title = 'Eaton Spark';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ThemeBloc().stream,
        builder: (context, AsyncSnapshot<ThemeState> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          GlobalColor.theme(snapshot.data!.theme);
          return MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: GlobalColor.primary,
                  brightness: Brightness.light,
                ),
                fontFamily: 'Avenir',
                switchTheme: SwitchThemeData(
                  thumbColor: MaterialStateProperty.all<Color>(
                    GlobalColor.primary,
                  ),
                  trackColor: MaterialStateProperty.all<Color>(
                    GlobalColor.primary.withOpacity(0.5),
                  ),
                ),
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: GlobalColor.primary,
                  brightness: Brightness.dark,
                ),
                fontFamily: 'Avenir',
              ),
              themeMode: snapshot.data!.theme,
              title: _title,
              initialRoute: AppRoutes.home,
              onGenerateRoute: (route) {
                return MaterialPageRoute(builder: (context) {
                  switch (route.name!.split('?')[0]) {
                    case AppRoutes.home:
                      return MainPage();
                    case AppRoutes.forgotPassword:
                      return ForgotPassword(
                        title: _title,
                        successCallback: () {
                          Navigator.pushNamed(context, AppRoutes.home);
                        },
                      );
                    case AppRoutes.signin:
                      return Signin(
                        title: _title,
                        successCallback: () {
                          Navigator.pushNamed(context, AppRoutes.home);
                        },
                      );

                    /// signup, signout, and resetPassword are not implemented
                    case AppRoutes.signup:
                      return Signup(
                        title: _title,
                        successCallback: () {
                          print('signup success');
                        },
                      );

                    case AppRoutes.resetPassword:
                      return ResetPassword(
                        title: _title,
                        successCallback: () {
                          print('reset password success');
                        },
                        params: route.name!.split('?')[1],
                      );
                    default:
                      return const NotFound();
                  }
                });
              });
        });
  }
}
