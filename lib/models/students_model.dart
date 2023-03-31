class Student {
  String? firstName;
  String? lastName;
  String? department;
  String? password;
  String? email;
  int?    studentno;

  Student({this.firstName,this.lastName,this.department,this.password,this.email,this.studentno});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      "lastName" : lastName,
      "department": department,
      'password': password,
      'email': email,
      "studentNo": studentno,

    };
  }
}
