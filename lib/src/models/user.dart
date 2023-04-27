import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel._internal();

  static UserModel _instance = UserModel._internal();

  factory UserModel() => _instance;

  static void setData(
      {String? uid, String? email, String? username, String? password}) {
    _uid = uid;
    _email = email;
    _username = username;
    _password = password;
  }

  static String? _uid;
  static String? _email;
  static String? _username;
  static String? _password;

  String? get uid => _uid;
  String? get email => _email;
  String? get username => _username;
  String? get password => _password;

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data() ?? {};
    if (data.isEmpty) {
      throw Exception("Document is empty");
    }

    _uid = data["uid"];
    _email = data["email"];
    _username = data["username"];
    _password = null;

    return _instance;
  }
  toMap() {
    return {
      "uid": _uid,
      "email": _email,
      "displayName": _username,
    };
  }
}
