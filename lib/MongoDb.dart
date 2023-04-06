import 'dart:developer';
import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telesaglikk/constants.dart ';
import 'package:mongo_dart/mongo_dart.dart';

import 'models/students_model.dart';
import 'package:bson/bson.dart';
import 'package:telesaglikk/screens/home_screen/home_screen.dart';

class MongoDataBase {
  static String? a,semail,sfirstName,slastName,sdepartment;
  static int? sstudentno;
  static var db, userCollection;
  static ObjectId? addd;
  static Student? at;
  static connect() async {
    db = await Db.create(DB_CONNECTION_STRING);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    userCollection = db.collection(Collection_Name);
    print(await userCollection.find().toList());
  }

  static Future<String?> insert(Student data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSucces) {
        return "Data İnserted";
      } else {
        return "Something wrong while İnserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String?> sorgu(String email, String password) async {
    var res = await userCollection
        .findOne(where.eq('email', '$email').eq('password', "$password"));
       a = "${res["_id"]}";
     sfirstName = "${res["firstName"]}";
    // ahmet?.id = res["_id"] ;
    // ahmet?.firstName = "${res["firstname"]}";
    // ahmet?.lastName = "${res["lastname"]}";
    // ahmet?.password = "${res["password"]}";
    // ahmet?.email = "${res["email"]}";
    // ahmet?.department = "${res["department"]}";
    // ahmet?.studentno = int.parse("${res["studentno"]}") ;
    print(a);
    print(sfirstName);
     //print(ahmet?.firstName);
    // _toprofi(res);

    if (res == null) {
      print('bulunamadı');
      return "bulunamadi";
    } else {
      print('Bulundu: '
          '${res['email']} - ${res['password']}  ');
            //studentGonder('${res['email']}');

           slastName= "${res["lastName"]}";
           sdepartment= "${res["department"]}";
           print("$sdepartment + $sstudentno");
           semail='${res['email']}';
           sstudentno = int.tryParse({res["studentNo"]}.toString());
      return "bulundu";
    } // Tom - active - 025456da-9e39-4e7c-b1f7-0f5a5e1cb212
  }

  static Future<List<Map<String, dynamic>>> getQueryData() async {
    final data = await userCollection.find().toList();
    for (var product in data) {
      print(product);
    }
    return data;
  }

  static Future<Student?>? studentGonder(String s) async {
    var at = await userCollection.findOne(where.eq('email', '$s'));

    if(at== null){
      print("hiçbir şey bulunamadı");
    }else{
      print("birşeyler bulduk");
      final datayenii = Student(
          id: at["_id"] ,
          firstName: "${at["firstname"]}",
          lastName: "${at["lastname"]}",
          department: "${at["department"]}",
          password: "${at["password"]}",
          email: "${at["email"]}",
          studentno: int.parse("${at["studentno"]}"));
      return datayenii;
    }


  }

  // static void _toprofi(res) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('studentId', res['_id'].toString());
  //
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? studentId = prefs.getString('studentId');
  //   if (studentId != null) {
  //     Student a = await userCollection.findOne(where.id(ObjectId.parse(studentId)));
  //
  //     // burada öğrencinin bilgilerini kullanarak profil sayfanızı doldurun
  //   }
  //
  //
  //
  // }
  //
  // Future<Student?> _lalaland(studentId) async{
  //   await userCollection.findOne(where.id(ObjectId.parse(studentId)));
  //   return studentId;
  // }
}
