import 'package:telesaglikk/models/doctors_model.dart';

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

   String? doctorId;
   String? patientId;
   String? patientFirstName;
   String? patientLastName;
   String?  date;
   String? hour;
   String? accepted;

   MyAppoinment(this.doctorId,this.patientId,this.patientFirstName,this.patientLastName,this.date,this.hour,this.accepted);



}