import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/routes.dart';
import 'package:eaton_spark/src/services/firebase/authentication.dart';
import 'package:eaton_spark/src/widgets/appbar/appbar.dart';
import 'package:eaton_spark/src/widgets/card/profile_card.dart';
import 'package:eaton_spark/src/widgets/sections/horizontal.dart';
import 'package:eaton_spark/src/widgets/sections/vertical.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  static const _USER_PLACEHOLDER_IMAGE_URL =
      "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(
          value: AuthenticationBloc(),
        ),
        BlocProvider<ThemeBloc>.value(
          value: ThemeBloc(),
        ),
      ],
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height -
            // MediaQuery.of(context).padding.top
            kToolbarHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  CustomAppbar(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            text: "Looking for ",
                            children: [
                              TextSpan(
                                text: "yourself",
                                style: TextStyle(
                                  color: GlobalColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                            child: Text(
                              FirebaseAuth.instance.currentUser!.displayName!,
                              style: TextStyle(
                                fontSize: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 16, 0),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  GlobalColor.primary,
                                  GlobalColor.secondary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //   color: GlobalColor.primary,
                              //   width: 2,
                              // ),
                            ),
                            child: CircleAvatar(
                              radius: 36,
                              foregroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL ??
                                      _USER_PLACEHOLDER_IMAGE_URL),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const HorizontalSection(
                  title: 'Suggested',
                  scrollable: false,
                  children: [
                    ProfileCard(
                      iconWidget: Icon(Icons.wallet),
                      title: "Wallet",
                    ),
                    ProfileCard(
                      iconWidget: Icon(Icons.currency_rupee_rounded),
                      title: "Payments",
                    ),
                    ProfileCard(
                      iconWidget: Icon(Icons.list_alt_rounded),
                      title: "Trips",
                    ),
                  ]),
              VerticalSection(
                  title: 'Other settings',
                  scrollable: false,
                  children: [
                    ProfileCard(
                      isLongCard: true,
                      iconWidget: Icon(Icons.color_lens_rounded),
                      title: "Theme",
                    ),
                    ProfileCard(
                      isLongCard: true,
                      title: "Language",
                      iconWidget: Icon(Icons.language_rounded),
                    ),
                    ProfileCard(
                      isLongCard: true,
                      title: "Help",
                      iconWidget: Icon(Icons.help_rounded),
                    ),
                    ProfileCard(
                      isLongCard: true,
                      title: "Logout",
                      navigates: false,
                      iconWidget: Icon(Icons.logout_rounded),
                      onTap: () async {
                        await AuthenticationService().signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.signin, (Route<dynamic> route) => false);
                      },
                    ),
                  ]),
            ],
          ),
        ),
      )),
    );
  }
}
