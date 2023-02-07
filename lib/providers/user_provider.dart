import 'package:flutter/material.dart';
import 'package:movies_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    uid: '',
    name: '',
    email: '',
    dateOfBirth: '',
    phoneNumber: '',
    favMovies: [],
  );

  UserModel get user => _user;

  set user(UserModel u) {
    _user = UserModel(
      uid: u.uid,
      name: u.name,
      email: u.email,
      dateOfBirth: u.dateOfBirth,
      phoneNumber: u.phoneNumber,
      favMovies: u.favMovies,
    );
    notifyListeners();
  }
}
