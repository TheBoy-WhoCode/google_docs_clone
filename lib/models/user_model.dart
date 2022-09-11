import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String uid;
  final String profilePic;
  final String token;
  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.token,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      uid: map['_id'] ?? '',
      profilePic: map['profilePic'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? email,
    String? name,
    String? uid,
    String? profilePic,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      token: token ?? this.token,
    );
  }
}
