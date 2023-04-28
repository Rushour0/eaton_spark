import 'package:eaton_spark/src/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:eaton_spark/src/models/authentication.dart';

part 'event.dart';
part 'state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        UserModel user = await AuthenticationModel.getCurrentUser().first;
        if (user.uid != "uid") {
          String? displayName = await AuthenticationModel.retrieveUserName();
          emit(AuthenticationSuccess(displayName: displayName));
        } else {
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOut) {
        emit(AuthenticationLogOut());
      }
    });
  }

  bool get isLoggedIn => true;

  Future<void> loginStarted() async {
    add(AuthenticationStarted());
  }

  Future<void> loggedOut() async {
    add(AuthenticationSignedOut());
  }
}
