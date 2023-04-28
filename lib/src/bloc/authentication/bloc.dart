import 'package:eaton_spark/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:eaton_spark/src/models/authentication.dart';

part 'event.dart';
part 'state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(AuthenticationInitial(
            isLoggedIn: FirebaseAuth.instance.currentUser != null)) {
    on<AuthenticationEvent>((event, emit) async {
      if (_isLoggedIn) {
        emit(const AuthenticationSuccess());
      } else if (event is AuthenticationStarted) {
        User? user = await AuthenticationModel.getCurrentUser().first;
        if (user != null) {
          _isLoggedIn = FirebaseAuth.instance.currentUser != null;
          emit(const AuthenticationSuccess());
        } else {
          _isLoggedIn = FirebaseAuth.instance.currentUser != null;
          emit(const AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOut) {
        _isLoggedIn = FirebaseAuth.instance.currentUser != null;
        emit(const AuthenticationLogOut());
      }
    });
  }

  bool _isLoggedIn = FirebaseAuth.instance.currentUser != null;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> loginStarted() async {
    add(AuthenticationStarted());
  }

  Future<void> loggedOut() async {
    add(AuthenticationSignedOut());
  }
}
