import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Student studentFromJson(String str) => Student.fromJson(jsonDecode(str));
String studentToJson(Student data) => jsonEncode(data.toJson());

class Student {
  ObjectId? id;
  String? firstName;
  String? lastName;
  String? department;
  String? password;
  String? email;
  int? studentno;

  Student(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.department,
      required this.password,
      required this.email,
      required this.studentno});



  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id:  json["_id"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      department: json['department'],
      password: json["password"],
      email: json['email'],
      studentno: json['studentno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      'firstName': firstName,      "lastName": lastName,
      "department": department,
      'password': password,
      'email': email,
      "studentNo": studentno,
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
