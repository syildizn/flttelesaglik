import 'dart:convert';

import 'package:telesaglikk/models/doctors_model.dart';

MyAppoinment myAppointmentFromJson(String str) => MyAppoinment.fromJson(jsonDecode(str));

class AssignmentData {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String lastDate;
  final String status;

  AssignmentData(this.subjectName, this.topicName, this.assignDate,
      this.lastDate, this.status);
}

List<AssignmentData> assignment = [
  AssignmentData(
      'AT', 'ZÜRAFA', 'BLA BLA', 'AYNEN MAHMUT', 'Pending'),
];

class FindDoctor{
   Doctor? doctor;


}

class MyAppoinment{

   String? id;
   String? doctorId;
   String? patientId;
   String? patientFirstName;
   String? patientLastName;
   String?  date;
   String? hour;
   String? accepted;

   MyAppoinment(this.doctorId,this.patientId,this.patientFirstName,this.patientLastName,this.date,this.hour,this.accepted);

   // factory  MyAppoinment.fromJson(Map<String, dynamic> json) {
   //   return MyAppoinment(
   //     id:  json["_id"],
   //     patientFirstName: json['patientFirstName'],
   //     patientLastName: json['lastName'],
   //     doctorId: json['doctorId'],
   //     date: json["date"],
   //     hour: json['hour'],
   //     patientId: json['patientId'],
   //     accepted: json["accepted"],
   //   );
   // }
   factory MyAppoinment.fromJson(Map<String, dynamic> json) {
     return MyAppoinment(
       json['doctorId'],
       json['patientId'],
       json['patientFirstName'],
       json['lastName'],
       json["date"],
       json['hour'],
       json["accepted"],
     );
   }

}