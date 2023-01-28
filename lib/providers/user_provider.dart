import 'package:flutter/material.dart';
import 'package:mobile_app_project/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
      uid: '',
      name: '',
      email: '',
      dateOfBirth: '',
      phoneNumber: '',
      favMovies: [],
      favTvs: []);

  UserModel get user => _user;

  set user(UserModel u) {
    _user = UserModel(
        uid: u.uid,
        name: u.name,
        email: u.email,
        dateOfBirth: u.dateOfBirth,
        phoneNumber: u.phoneNumber,
        favMovies: u.favMovies,
        favTvs: u.favTvs);
    notifyListeners();
  }
}
