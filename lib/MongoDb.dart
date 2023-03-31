import 'dart:developer';

import 'package:telesaglikk/constants.dart ';
import 'package:mongo_dart/mongo_dart.dart';
class MongoDataBase{

 static connect() async{


  var db = await Db.create(DB_CONNECTION_STRING);
  await db.open();
  inspect(db);
  var status = db.serverStatus();
  print(status);
  var collection = db.collection(Collection_Name);
  print(await collection.find().toList());


 }


 void addStudent(Map<String, dynamic> studentData) async {
   final db = await Db.create(DB_CONNECTION_STRING);
   await db.open();
   final collection = db.collection('students');
   await collection.insert(studentData);
   await db.close();
 }

 String get myFunctionResult => connect();


}