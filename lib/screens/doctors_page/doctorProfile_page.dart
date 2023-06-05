import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';
import 'package:telesaglikk/screens/appointment_screen/appointment_page.dart';
import '../../models/doctors_model.dart';
import '../assignment_screen/assignment_screen.dart';
import '../general_screen/general_screen.dart';
import '../home_screen/home_screen.dart';
import '../my_profile/my_profile.dart';

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
  var tarihStr;

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
          future: MongoDataBase.appointmentsorgu(time,"sasd",doctor?.id?.$oid),
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
      builder: (BuildContext context, Widget? child) {
      return Theme(
        data: theme,
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            // Burada her gün için ayrı bir tarih değeri hesaplanır.
            // Örneğin bugünden itibaren 7 gün sonrasına kadar olan tarihler hesaplanır.
            final tarih = DateTime.now().add(Duration(days: index));
             tarihStr = DateFormat('yyyy-MM-dd').format(tarih);

            return Column(
              children: [
                // Text(tarihStr,style: TextStyle(
                //   fontWeight: FontWeight.normal,
                //   fontSize: 35,
                //   color: Colors.white,
                // ),),
                TextButton(onPressed: (){
                  buildAppointmentTimes(context,tarihStr);
                }, child: Text(tarihStr,style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 35,
                  color: Colors.white,
                ),),)// Tarihi ekrana yazdırırız.
                //buildAppointmentTimes(context, tarihStr), // Her gün için ayrı saat dilimi tuşları oluşturulur.
              ],
            );
          },
        ),
      );
    },

    );

    /* final DateTime? pickedDate = await*/

    print("pickedDate:$pickedDate");
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
                child: buildAppointmentTimes(context,tarihStr),
              ),
            ),
          );
        },
      );


      //print("$pickedTime saat");
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
          Expanded(flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.34,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // sizedBox,

          Expanded(flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(scrollDirection:Axis.vertical,
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
                         // _selectDateAndTime(context);
                          Navigator.pushNamed(

                              context, AppointmentPage.routeName);
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
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: kDefaultPadding * 2,
          right: kDefaultPadding * 2,
          bottom: kDefaultPadding,
        ),
        height: 70,
        decoration: BoxDecoration(
            color: homepagefont, //.withOpacity(0.40),Colors.white,
            boxShadow: [
              /* BoxShadow(
              offset: Offset(0,-10),
              blurRadius: 35,
              color: kBkrColor.withOpacity(0.38),
            )*/
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              },
              icon: SvgPicture.asset(
                'assets/icons/homei.svg',
                width: 50,
                height: 50,
              ),
            ), //Icon(Icons.home_outlined),),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AssignmentScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/conferance.svg',
                width: 50,
                height: 50,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, GeneralScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/icecream.svg',
                width: 50,
                height: 50,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyProfileScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/profilo.svg',
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }




}
