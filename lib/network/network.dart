//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/model/user_model.dart';

class Network {
  createNewUser({required email, required password}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      await users.doc(user.user!.uid).set({
        'uid': user.user!.uid,
        'email': email,
        'name': '',
        'dateOfBirth': '',
        'phoneNumber': '',
        'favMovies': [],
      });
    });
  }

  getUserProfile({required uid}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var document = await users.doc(uid).get();
    print('From Network> ${document.data()}');
    return document;
  }

  updateUserProfile({required UserModel user, required uid}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(uid).update({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
      'dateOfBirth': user.dateOfBirth,
      'phoneNumber': user.phoneNumber,
      'favMovies': user.favMovies,
    });
    var document = await users.doc(uid).get();
    print('From Network> ${document.data()}');
    return document;
  }

  signInUser({required email, required password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  forgotPassword({required email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  addToFavoriteMovies(List<dynamic> favMovies) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var document = await users.doc(uid).get();
    await users.doc(uid).update({
      'favMovies': favMovies,
    });
  }
}
