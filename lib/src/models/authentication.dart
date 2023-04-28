import 'package:eaton_spark/src/bloc/authentication/bloc.dart';
import 'package:eaton_spark/src/models/user.dart';
import 'package:eaton_spark/src/services/firebase/authentication.dart';
import 'package:eaton_spark/src/services/firebase/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModel {
  static AuthenticationModel _instance = AuthenticationModel._internal();
  factory AuthenticationModel() {
    return _instance;
  }

  AuthenticationModel._internal();

  static AuthenticationService service = AuthenticationService();
  static DatabaseService dbService = DatabaseService();

  static Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  static Future<UserCredential?> signUp(
      {required String name, required String email, required String password}) {
    try {
      dbService.addUserData(UserModel());
      return service.signUp(name: name, email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  static Future<UserCredential?> signIn(
      {required String email, required String password}) {
    try {
      AuthenticationBloc().loginStarted();
      return service.signIn(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  static Future<void> resetPassword({required String email}) {
    return service.resetPassword(email: email);
  }

  static Future<void> confirmPasswordReset(
      {required String code,
      required String password,
      required String passwordAgain}) {
    try {
      if (password != passwordAgain) {
        throw FirebaseAuthException(
            code: 'passwords-do-not-match',
            message: 'Passwords do not match. Please try again.');
      }
    } on Exception catch (e) {
      throw e;
    }

    return service.confirmPasswordReset(code: code, password: password);
  }

  static Future<void> signOut() {
    service.signOut();
    return AuthenticationBloc().loggedOut();
  }

  static Future<String?> retrieveUserName() {
    return dbService.retrieveUserName();
  }
}
