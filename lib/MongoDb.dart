import 'dart:developer';
//import 'dart:html';

import 'package:telesaglikk/constants.dart ';
import 'package:mongo_dart/mongo_dart.dart';

import 'models/students_model.dart';

class MongoDataBase {
  static var db, userCollection;

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

  static Future<List<Map<String,dynamic>>> getQueryData() async{
    final data = await userCollection.find().toList();
    return data;

  }
}
