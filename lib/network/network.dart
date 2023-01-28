//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_project/model/review_model.dart';
import 'package:mobile_app_project/model/user_model.dart';
import 'package:mobile_app_project/widgets/review_widgets/reviewbox.dart';

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
        'favTvs': [],
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
      'favTvs': user.favTvs,
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

  addToFavoriteTvs(List<dynamic> favTvs) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var document = await users.doc(uid).get();
    await users.doc(uid).update({
      'favTvs': favTvs,
    });
  }

  addReview({required ReviewModel review}) async {
    CollectionReference reviews =
        FirebaseFirestore.instance.collection('reviews');
    await reviews.doc().set({
      'showId': review.showId,
      'showName': review.showName,
      'posterPath': review.posterPath,
      'uid': review.uid,
      'userName': review.userName,
      'reviewTitle': review.reviewTitle,
      'reviewBody': review.reviewBody,
      'rating': review.rating,
      'publishDate': review.publishDate,
    });
  }

  updateReview({required ReviewModel review, required id}) async {
    final reviews = FirebaseFirestore.instance.collection('reviews');
    final query = reviews.where("publishDate", isEqualTo: id);
    final snapshot = await query.get();
    snapshot.docs.forEach((document) async {
      await document.reference.update({
        'showId': review.showId,
        'showName': review.showName,
        'posterPath': review.posterPath,
        'uid': review.uid,
        'userName': review.userName,
        'reviewTitle': review.reviewTitle,
        'reviewBody': review.reviewBody,
        'rating': review.rating,
        'publishDate': review.publishDate,
      });
    });
  }

  deleteReview({required id}) async {
    final reviews = FirebaseFirestore.instance.collection('reviews');
    final query = reviews.where("publishDate", isEqualTo: id);
    final snapshot = await query.get();
    snapshot.docs.forEach((document) async {
      await document.reference.delete();
    });
  }
}
