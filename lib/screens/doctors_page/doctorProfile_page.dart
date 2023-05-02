import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';

import '../../jitsi.dart';

class DoctorProfilePage extends StatefulWidget {
  static String routeName = 'DoctorProfilePage';
  static String? imageUrl;

  static Student? doctor;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print(doctor?.firstName);

    print("doctor id: ${doctor?.id?.$oid}");
    return _DoctorProfilePageState();
  }
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Student doctor;
  late String? imageUrl;
  var selectedTime;
  var selectedDate;


  final ThemeData theme = ThemeData(
    primarySwatch: Colors.cyan,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 26),
    ),
  );

  final List<String> appointmentTimes = ['09:00',"10:00", '11:00', "12:00" ,'13:00',"14:00", '15:00',"16:00" ];

  @override
  void initState() {
    super.initState();
    doctor = DoctorProfilePage.doctor!;
    imageUrl = DoctorProfilePage.imageUrl;
    print(imageUrl);
  }



  // Randevu saatlerini gösteren widget
  // Widget buildAppointmentTimes(BuildContext context) {
  //   return Column(
  //
  //     children: appointmentTimes.map((time) {
  //       // Burada veritabanından randevu saatlerini kontrol edebilir ve eğer o saat doluysa butonu devre dışı bırakabilirsiniz.
  //       bool isTimeAvailable = true ;
  //
  //         MongoDataBase.appointmentsorgu(time).then((value) {
  //           print("value:$value");
  //           print("time:$time");
  //          //var  j=value;
  //           if(time == value){
  //             isTimeAvailable = false ;
  //           } else {
  //             isTimeAvailable = true ;
  //           }
  //           print("son durum: $isTimeAvailable");
  //         });
  //
  //      print("son durum: $isTimeAvailable");
  //       return ElevatedButton(
  //         onPressed:isTimeAvailable ?  (){
  //           final timeParts = time.split(':');
  //           final hour = int.parse(timeParts[0]);
  //           final minute = int.parse(timeParts[1]);
  //           var selectedTime = TimeOfDay(hour: hour, minute: minute);
  //           print("selected time: $selectedTime");
  //           print("portakal2: ");
  //           Navigator.of(context).pop(selectedTime);
  //           //final elma = TimeOfDay(hour: hour, minute: minute),
  //
  //           //Navigator.of(context).pop(time);
  //           print("$time şimdilik time");
  //           _createAppointment(time);
  //         }
  //         : null, //() => _createAppointment(time) : null,
  //         child: Text(time),
  //         style: ElevatedButton.styleFrom(
  //           primary: kBkrColor, // background
  //           onPrimary: Colors.white, // foreground
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10)),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget buildAppointmentTimes(BuildContext context) {
    return Column(
      children: appointmentTimes.map((time) {
        return FutureBuilder(
          future: MongoDataBase.appointmentsorgu(time),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            bool isTimeAvailable = snapshot.hasData ? snapshot.data == null : true;
            print("selected datemiş $selectedDate");
            return ElevatedButton(
              onPressed: isTimeAvailable ? () {
                final timeParts = time.split(':');
                final hour = int.parse(timeParts[0]);
                final minute = int.parse(timeParts[1]);
                var selectedTime = TimeOfDay(hour: hour, minute: minute);
                Navigator.of(context).pop(selectedTime);
                _createAppointment(time);
              } : null,
              child: Text(time),
              style: ElevatedButton.styleFrom(
                primary: kBkrColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }


// Randevu oluşturma fonksiyonu
  String _createAppointment(String time) {
    // Burada seçilen saat bilgisini kullanarak randevu oluşturma işlemini gerçekleştirebilirsiniz.
    return time;
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    print(pickedDate);
    if (pickedDate != null) {
      // final TimeOfDay? pickedTime = await showTimePicker(
      //   context: context,
      //   initialTime: TimeOfDay.now(),
      // );
      // final TimeOfDay? pickedTime = await showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       content: buildAppointmentTimes(context),
      //     );
      //   },
      // );

      // final TimeOfDay? pickedTime = await showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       contentPadding: EdgeInsets.all(10),
      //       content: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(10),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.5),
      //               spreadRadius: 2,
      //               blurRadius: 5,
      //               offset: Offset(0, 3),
      //             ),
      //           ],
      //         ),
      //         child: buildAppointmentTimes(context),
      //       ),
      //     );
      //   },
      // );


      // final TimeOfDay? pickedTime = await showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return Stack(
      //       children: [
      //         // Arkaplan için container
      //         Container(
      //           decoration: BoxDecoration(
      //             color: Colors.transparent.withOpacity(0.5), // Şeffaflık değeri 0.5
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.transparent.withOpacity(0.5), // Gölge rengi ve şeffaflık değeri
      //                 spreadRadius: 5,
      //                 blurRadius: 7,
      //                 offset: Offset(1, 3), // Gölgenin yönü ve yoğunluğu
      //               ),
      //             ],
      //           ),
      //         ),
      //         // Dialog için container
      //         AlertDialog(
      //           content: buildAppointmentTimes(context),
      //         ),
      //       ],
      //     );
      //   },
      // );

      final TimeOfDay? pickedTime = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.78),
            elevation: 60.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width*0.05,
                child: buildAppointmentTimes(context),
              ),
            ),
          );
        },
      );


      print("$pickedTime tarih");
      if (pickedTime != null) {
        // Burada seçilen tarih ve saat bilgilerini MongoDB veritabanına kaydedebilirsiniz.
        // Ayrıca randevu saatlerinin dolu olup olmadığını kontrol etmek için de MongoDB veritabanındaki randevu bilgilerini sorgulayabilirsiniz.
         selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

         selectedTime = pickedTime.format(context);
          if(selectedTime== "9:00 AM"){
            selectedTime = "09:00";
          }else if(selectedTime== "10:00 AM"){
            selectedTime = "10:00";
          }else if(selectedTime== "11:00 AM"){
            selectedTime = "11:00";
          }else if(selectedTime== "12:00 PM"){
            selectedTime = "12:00";
          }else if(selectedTime== "1:00 PM"){
            selectedTime = "13:00";
          }else if(selectedTime== "2:00 PM"){
            selectedTime = "14:00";
          }else if(selectedTime== "3:00 PM"){
            selectedTime = "15:00";
          }else if(selectedTime== "4:00 PM"){
            selectedTime = "16:00";
          }
        // Burada MongoDB veritabanına bağlanarak randevu bilgilerini kaydedebilirsiniz.
        // Örnek amaçlı burada sadece bir debug mesajı yazdırıyoruz.
        print('Randevu oluşturuldu: $selectedDate $selectedTime');
        await MongoDataBase.appointment(selectedDate, selectedTime,doctor?.id?.$oid);

      }
    }
  }



  Future<String> randevusorgu() async{
    var s = await MongoDataBase.appointmentsorgu( selectedTime);
    if(s != null && s == "bulundu"){
      print("bulundumu: $s");
      return "a";
    }else {
      print("bulundumu: nah bulundu");
      return "b";
    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: homepagefont,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kBkrColor,
          size: 25,
        ),
        backgroundColor: homepagefont,
        title: Text("${doctor.firstName} ${doctor.lastName}",
            textScaleFactor: 1,
            style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: kBkrColor,
            ))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.34,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl!),
                fit: BoxFit.cover,
              ),
            ),

          ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(

                onPressed: () {
                  final secilenogrenci = '${doctor.firstName}_${doctor.lastName}';
                  final roomName = RegExp(r'^[a-zA-Z0-9_-]+$').stringMatch(secilenogrenci);

                  Jitsi.joinMeeting(secilenogrenci!);
                },
                child: Text('Görüntülü Arama'),
                style: ElevatedButton.styleFrom(
                  primary: kBkrColor, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sesli Arama '),
                style: ElevatedButton.styleFrom(
                  primary: kBkrColor, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),

              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Mesajlaşma'),
                  style: ElevatedButton.styleFrom(
                  primary: kBkrColor, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              ),
              )],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kalp Damar Cerrahı",
                  style: TextStyle(color: Colors.black),
                ),
                sizedBox,
                Text(
                  "Hakkında ",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                SizedBox(height: 7),
                Text(
                  "Dr. Mehmet Yılmaz, İstanbul Üniversitesi Tıp Fakültesi'nden"
                  " mezun olduktan sonra Duke Üniversitesi'nde kardiyovasküler"
                  " cerrahi eğitimi aldı. Türkiye'ye dönüp bir özel hastanede"
                  " çalıştıktan sonra 2005'te kendi kliniğini açtı. Dr. Yılmaz, "
                  "kardiyovasküler cerrahi konusunda uzman ve hastalarına kişisel"
                  " bir yaklaşım benimseyen bir doktordur. Ayrıca, Türkiye Kardiyovasküler"
                  " Cerrahi Derneği üyesi ve cerrahi yayınların yazarı/hakemidir.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                sizedBox,
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDateAndTime(context);
                    },
                    child: Text('Randevu Oluştur'),
                    style: ElevatedButton.styleFrom(
                      primary: kBkrColor, // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
