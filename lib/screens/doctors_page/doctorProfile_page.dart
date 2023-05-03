import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';
import '../../jitsi.dart';
import '../../models/doctors_model.dart';

class DoctorProfilePage extends StatefulWidget {
  static String routeName = 'DoctorProfilePage';
  static String? imageUrl;

  static Doctor? doctor;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print(doctor?.firstName);

    print("doctor id: ${doctor?.id?.$oid}");
    return _DoctorProfilePageState();
  }
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Doctor doctor;
  late String? imageUrl;
  var selectedTime;
  var selectedDate;

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.cyan,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 26),
    ),
  );

  List<String> appointments = [];

    List<String> appointmentTimes = [
     '09:00',
   "10:00",
    '11:00',
    "12:00",
    '13:00',
     "14:00",
    '15:00',
    "16:00"
  ];

  @override
  void initState() {
    super.initState();
    doctor = DoctorProfilePage.doctor!;
    imageUrl = DoctorProfilePage.imageUrl;
    print(imageUrl);
  }

  Widget buildAppointmentTimes(BuildContext context, String tarihStr) {
    return Column(
      children: appointmentTimes.map((time) {
        return FutureBuilder(
          future: MongoDataBase.appointmentsorgu(time,"2023-05-20"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            bool isTimeAvailable =
                snapshot.hasData ? snapshot.data == null : true;
            print("selected datemiş bu istediğim $selectedDate");
            return ElevatedButton(
              onPressed: isTimeAvailable
                  ? () {
                      final timeParts = time.split(':');
                      final hour = int.parse(timeParts[0]);
                      final minute = int.parse(timeParts[1]);
                      var selectedTime = TimeOfDay(hour: hour, minute: minute);
                      Navigator.of(context).pop(selectedTime);

                    }
                  : null,
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

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? ListView/*child*/) {
        return Theme(
          data: theme,
          child:ListView?.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              // Burada her gün için ayrı bir tarih değeri hesaplanır.
              // Örneğin bugünden itibaren 7 gün sonrasına kadar olan tarihler hesaplanır.
              final tarih = DateTime.now().add(Duration(days: index));
              final tarihStr = DateFormat('yyyy-MM-dd').format(tarih);

              return Column(
                children: [
                  Text(tarihStr), // Tarihi ekrana yazdırırız.
                  buildAppointmentTimes(context, tarihStr), // Her gün için ayrı saat dilimi tuşları oluşturulur.
                ],
              );
            },
          ) ,//child!,
        );
      },
      // builder: ListView.builder(
      //   itemCount: 7,
      //   itemBuilder: (context, index) {
      //     // Burada her gün için ayrı bir tarih değeri hesaplanır.
      //     // Örneğin bugünden itibaren 7 gün sonrasına kadar olan tarihler hesaplanır.
      //     final tarih = DateTime.now().add(Duration(days: index));
      //     final tarihStr = DateFormat('yyyy-MM-dd').format(tarih);
      //
      //     return Column(
      //       children: [
      //         Text(tarihStr), // Tarihi ekrana yazdırırız.
      //         buildAppointmentTimes(context, tarihStr), // Her gün için ayrı saat dilimi tuşları oluşturulur.
      //       ],
      //     );
      //   },
      //  );

    );

    /* final DateTime? pickedDate = await*/

    print(pickedDate);
    if (pickedDate != null) {
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
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.05,
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
        if (selectedTime == "9:00 AM") {
          selectedTime = "09:00";
        } else if (selectedTime == "10:00 AM") {
          selectedTime = "10:00";
        } else if (selectedTime == "11:00 AM") {
          selectedTime = "11:00";
        } else if (selectedTime == "12:00 PM") {
          selectedTime = "12:00";
        } else if (selectedTime == "1:00 PM") {
          selectedTime = "13:00";
        } else if (selectedTime == "2:00 PM") {
          selectedTime = "14:00";
        } else if (selectedTime == "3:00 PM") {
          selectedTime = "15:00";
        } else if (selectedTime == "4:00 PM") {
          selectedTime = "16:00";
        }
        // Burada MongoDB veritabanına bağlanarak randevu bilgilerini kaydedebilirsiniz.
        // Örnek amaçlı burada sadece bir debug mesajı yazdırıyoruz.
        print('Randevu oluşturuldu: $selectedDate $selectedTime');
        await MongoDataBase.appointment(
            selectedDate, selectedTime, doctor?.id?.$oid);
      }
    }
  }

  // Future<String> randevusorgu() async {
  //   var s = await MongoDataBase.appointmentsorgu(selectedTime,selectedDate);
  //   if (s != null && s == "bulundu") {
  //     print("bulundumu: $s");
  //     return "a";
  //   } else {
  //     print("bulundumu: nah bulundu");
  //     return "b";
  //   }
  // }

  // Widget buildAppointmentTimes(BuildContext context) {
  //   return Column(
  //     children: appointmentTimes.map((time) {
  //       return FutureBuilder(
  //         future: MongoDataBase.appointmentsorgu(time, selectedDate),
  //         builder: (BuildContext context, AsyncSnapshot snapshot) {
  //           bool isTimeAvailable =
  //           snapshot.hasData ? snapshot.data == null : true;
  //           return ElevatedButton(
  //             onPressed: isTimeAvailable
  //                 ? () {
  //               final timeParts = time.split(':');
  //               final hour = int.parse(timeParts[0]);
  //               final minute = int.parse(timeParts[1]);
  //               var selectedTime = TimeOfDay(hour: hour, minute: minute);
  //               Navigator.of(context).pop(selectedTime);
  //               _createAppointment(time);
  //             }
  //                 : null,
  //             child: Text(time),
  //           );
  //         },
  //       );
  //     }).toList(),
  //   );
  // }
  //
  // // void initState() {
  // //
  // // }
  //
  // List<String> _generateTimes(DateTime date) {
  //   List<String> times = [];
  //   final now = DateTime.now();
  //   var startDate = DateTime(date.year, date.month, date.day, 9, 0);
  //   final endDate = DateTime(date.year, date.month, date.day, 17, 0);
  //   if (date.day == now.day) {
  //     final startHour = now.hour + 1;
  //     startDate = startDate.add(Duration(hours: startHour - startDate.hour));
  //
  //   }
  //   while (startDate.isBefore(endDate)) {
  //     times.add('${startDate.hour.toString().padLeft(2, '0')}:00');
  //     times.add('${startDate.hour.toString().padLeft(2, '0')}:30');
  //     startDate = startDate.add(Duration(minutes: 30));
  //   }
  //   return times;
  // }
  //
  // void _selectDateAndTime(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2100));
  //   if (picked != null) {
  //     setState(() {
  //       selectedDate = picked;
  //       appointmentTimes = _generateTimes(selectedDate);
  //     });
  //     final TimeOfDay? timePicked = await showTimePicker(
  //         context: context,
  //         initialTime: TimeOfDay.now(),
  //         builder: (BuildContext context, Widget? child) {
  //           return MediaQuery(
  //             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //             child: child!,
  //           );
  //         });
  //     if (timePicked != null){
  //       final selectedDateTime = DateTime(
  //         picked.year,
  //         picked.month,
  //         picked.day,
  //         timePicked.hour,
  //         timePicked.minute,
  //       );
  //       final now = DateTime.now();
  //       if (selectedDateTime.isBefore(now)) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Geçmiş bir zaman seçilemez.'),
  //             duration: Duration(seconds: 2),
  //           ),
  //         );
  //       } else {
  //         _createAppointment(selectedDateTime.toString());
  //         Navigator.of(context).pop();
  //       }
  //     }
  //   }
  //
  // }
  //   void _createAppointment(String time) async{
  //     setState(() {
  //       appointments.add(time);
  //     });
  //     //MongoDataBase.createAppointment(time, selectedDate);
  //     await MongoDataBase.appointment(selectedDate, selectedTime, doctor?.id?.$oid);
  //   }


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
                  final secilenogrenci =
                      '${doctor.firstName}_${doctor.lastName}}';
                  final roomName =
                      RegExp(r'^[a-zA-Z0-9_-]+$').stringMatch(secilenogrenci);

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
              )
            ],
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
                  "${doctor.bio}",
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
