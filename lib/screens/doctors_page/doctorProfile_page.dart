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
    return _DoctorProfilePageState();
  }
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Student doctor;
  late String? imageUrl;

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.cyan,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 26),
    ),
  );

  final List<String> appointmentTimes = ['09:00',"10:00", '11:00', "12:00" ,'13:00',"14:00", '15:00',"16:00" ,'17:00'];

  @override
  void initState() {
    super.initState();
    doctor = DoctorProfilePage.doctor!;
    imageUrl = DoctorProfilePage.imageUrl;
    print(imageUrl);
  }

  // Randevu saatlerini gösteren widget
  Widget buildAppointmentTimes(BuildContext context) {
    return Column(
      children: appointmentTimes.map((time) {
        // Burada veritabanından randevu saatlerini kontrol edebilir ve eğer o saat doluysa butonu devre dışı bırakabilirsiniz.
        final bool isTimeAvailable = true; // Örnek amaçlı her zaman true olarak ayarlandı.
        return ElevatedButton(
          onPressed:isTimeAvailable ? (){
            final timeParts = time.split(':');
            final hour = int.parse(timeParts[0]);
            final minute = int.parse(timeParts[1]);
            final selectedTime = TimeOfDay(hour: hour, minute: minute);
            Navigator.of(context).pop(selectedTime);
            //Navigator.of(context).pop(time);
            print("$time şimdilik time");
            _createAppointment(time);
          }: null, //() => _createAppointment(time) : null,
          child: Text(time),
          style: ElevatedButton.styleFrom(
            primary: kBkrColor, // background
            onPrimary: Colors.white, // foreground
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
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
      final TimeOfDay? pickedTime = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: buildAppointmentTimes(context),
          );
        },
      );

     print("$pickedTime tarih");
      if (pickedTime != null) {
        // Burada seçilen tarih ve saat bilgilerini MongoDB veritabanına kaydedebilirsiniz.
        // Ayrıca randevu saatlerinin dolu olup olmadığını kontrol etmek için de MongoDB veritabanındaki randevu bilgilerini sorgulayabilirsiniz.
        final String selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        final String selectedTime = pickedTime.format(context);
        // Burada MongoDB veritabanına bağlanarak randevu bilgilerini kaydedebilirsiniz.
        // Örnek amaçlı burada sadece bir debug mesajı yazdırıyoruz.
        print('Randevu oluşturuldu: $selectedDate $selectedTime');
        await MongoDataBase.appointment(selectedDate, selectedTime);
      }
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
