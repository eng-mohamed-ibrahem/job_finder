// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int id;
  String name;
  String otp;
  String? towStep;
  String email;
  String? emailVerifiedAt;
  String createdAt;
  String? updatedAt;
  String token;
  UserModel({
    required this.id,
    required this.name,
    required this.otp,
    this.towStep,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    this.updatedAt,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'otp': otp,
      'towStep': towStep,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      otp: map['otp'] as String,
      towStep: map['towStep'] != null ? map['towStep'] as String : null,
      email: map['email'] as String,
      emailVerifiedAt: map['emailVerifiedAt'] != null ? map['emailVerifiedAt'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, otp: $otp, towStep: $towStep, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }
}
