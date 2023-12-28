import 'package:flutter/widgets.dart';
import 'package:hotfocus/data/models/user.dart' as model;

import '../resources/auth_methods.dart';


class UserProvider with ChangeNotifier {
  model.UserData? _user;
  final AuthMethods _authMethods = AuthMethods();

  model.UserData get getUser => _user!;

  Future<void> refreshUser() async {
    model.UserData user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}