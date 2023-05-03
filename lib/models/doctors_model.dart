import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Doctor studentFromJson(String str) => Doctor.fromJson(jsonDecode(str));
String studentToJson(Doctor data) => jsonEncode(data.toJson());

class Doctor{
  ObjectId? id;
  String? firstName;
  String? lastName;
  String? department;
  String? password;
  String? email;
  String? doctorno;
  String? bio;

  Doctor(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.department,
        required this.password,
        required this.email,
        required this.doctorno,
        required this.bio});



  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id:  json["_id"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      department: json['department'],
      password: json["password"],
      email: json['email'],
      doctorno: json['doctorno'],
      bio: json["bio"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      'firstName': firstName,
      "lastName": lastName,
      "department": department,
      'password': password,
      'email': email,
      "doctorno": doctorno,
      "bio":bio,
    };
  }
// Map<String, dynamic> toMap() {
//   return {
//     'firstName': firstName,
//     "lastName" : lastName,
//     "department": department,
//     'password': password,
//     'email': email,
//     "studentNo": studentno,
//
//   };
// }
}
