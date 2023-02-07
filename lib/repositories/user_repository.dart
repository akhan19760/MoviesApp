import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/user_model.dart';
import 'package:movies_app/network/network.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserRepository {
  static Network network = Network();

  static getUserProfile(uid, BuildContext context) async {
    var user = await network.getUserProfile(uid: uid);
    Map<String, dynamic> data = user.data();
    print(data);
    UserModel userModel = UserModel.fromJson(data);
    return userModel;
    // context.read<UserProvider>().user = userModel;
    // UserModel userModel = UserModel(
    //     uid: data['uid'],
    //     name: data['name'],
    //     email: data['email'],
    //     dateOfBirth: data['dateOfBirth'],
    //     phoneNumber: data['phoneNumber'],
    //     photoUrl: data['photoUrl']);
    // print('From Repository> ${user.data().runtimeType}');
    // print('From Repository2> ${user.data()}');
    // UserModel userModel = user.data();
    // print(userModel.uid);
  }

  static createNewUser(email, password, BuildContext context) async {
    var user = await network.createNewUser(email: email, password: password);
    //Map<String, dynamic> data = user.data();
    //print(data);
    // UserModel userModel = UserModel.fromJson(data);
    // return userModel;
  }

  static updateUserProfile(
      UserModel userModel, uid, BuildContext context) async {
    var user = await network.updateUserProfile(user: userModel, uid: uid);
    Map<String, dynamic> data = user.data();
    UserModel u = UserModel.fromJson(data);
    return u;
  }
}
