class UserModel {
  final String uid;
  final String name;
  final String email;
  final String dateOfBirth;
  final String phoneNumber;
  final List<dynamic> favMovies;
  final List<dynamic> favTvs;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.favMovies,
      required this.favTvs});

  static fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'],
        phoneNumber: json['phoneNumber'],
        favMovies: json['favMovies'],
        favTvs: json['favTvs']);
  }

  toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dob': dateOfBirth,
      'phone': phoneNumber,
      'favMovies': favMovies,
      'favTvs': favTvs,
    };
  }
}
