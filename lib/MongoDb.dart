import 'dart:developer';
import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telesaglikk/constants.dart';

import 'package:mongo_dart/mongo_dart.dart';

import 'models/students_model.dart';
import 'package:bson/bson.dart';
import 'package:telesaglikk/screens/home_screen/home_screen.dart';

class MongoDataBase {
  static String? a,semail,sfirstName,slastName,sdepartment;
  static String? sstudentno;
  static var db, userCollection, doctorCollection , dbiki ,appointnmentCollection;
  static ObjectId? addd;
  static Student? at;
  static connect() async {
    db = await Db.create(DB_CONNECTION_STRING);
   // dbiki = await Db.create(DB_CONNECTION_STRING);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    userCollection = db.collection(Collection_Name);
    doctorCollection = db.collection(Collection_Doctor);
    appointnmentCollection = db.collection(Collection_Appointment);
    print(await userCollection.find().toList());
    print(await doctorCollection.find().toList());
    print(await appointnmentCollection.find().toList());
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

  static Future<String?> appointment(String day, String time, String? doctorId) async {
    try {
      print("Buraya gelebildi.");
      final newAppointment = {
        "_id" : ObjectId(),
        "doctorId" : doctorId,
        "patientId" : sstudentno,
        "patientFirstName": sfirstName,
        "patientLastName": slastName,
        'date': day,
        'hour': time,
        "accepted": "1",

        // 'accepted' : "0"
      };

      var result = await appointnmentCollection.insertOne(newAppointment);
      print("Buraya bak :$result $day $time " );
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

  static Future<bool> appointmentsorgu(String date,String time,String? doctori) async {

    var resi = await appointnmentCollection.findOne(where.eq('date', "$date").eq("hour", time).eq("doctorId","$doctori"));
    a = "${resi["_id"]} randevu id";
    print(a);
    if (resi != null) {
      print('randevu bulundu:${resi['date']} - ${resi['time']}');
      return false;
    } else {
      print('Randevu Bulunamadı');
      return true;
    }
  }


  static Future<List<Map<String,dynamic>>> myappointmentsorgu(String patientId) async {

    //var resi = await appointnmentCollection.find(where.eq('patientId', "$patientId"));
   // var al = await appointnmentCollection.find(where.eq('patientId', "$sstudentno")); ;

    final query = where.eq('patientId', "$patientId"); // patientId değerine göre filtreleme

    final cursor = appointnmentCollection.find(query);
    final myappointments = await cursor.toList();
    //var al = await appointnmentCollection.find().toList();
    print("istediğim randevular: $myappointments");
    return myappointments;


  }



  static Future<String?> sorgu(String email, String password) async {
    var res = await userCollection
        .findOne(where.eq('email', '$email').eq('password', "$password"));
       a = "${res["_id"]}";
     sfirstName = "${res["firstName"]}";

    print(a);
    print(sstudentno);


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
           sstudentno = "${res["studentNo"]}";
           print("$sstudentno ögrenci no");
      return "bulundu";
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final dataDoctors = await doctorCollection.find().toList(); //await userCollection.find().toList();

    return dataDoctors;
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


}
