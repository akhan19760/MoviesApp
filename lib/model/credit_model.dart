class Cast {
  String? knownForDepartment;
  String? originalName;
  dynamic? profilePath;
  String? character;

  Cast({
    this.knownForDepartment,
    this.originalName,
    this.profilePath,
    this.character,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    knownForDepartment = json['known_for_department'];
    originalName = json['original_name'];
    profilePath = json['profile_path'];
    character = json['character'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['known_for_department'] = this.knownForDepartment;
    data['original_name'] = this.originalName;
    data['profile_path'] = this.profilePath;
    data['character'] = this.character;
    return data;
  }
}
