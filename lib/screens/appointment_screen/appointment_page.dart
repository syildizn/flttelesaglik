import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:telesaglikk/constants.dart%20';

import '../../MongoDb.dart';
import '../../models/doctors_model.dart';
import '../assignment_screen/assignment_screen.dart';
import '../general_screen/general_screen.dart';
import '../home_screen/home_screen.dart';
import '../my_profile/my_profile.dart';

class AppointmentPage extends StatefulWidget {
  static String routeName = 'AppointmentPage';
  static Doctor? doctor;

  @override
  State<StatefulWidget> createState() {
    print(doctor?.firstName);
    // TODO: implement createState
    return _AppointmentPage();
  }
}

class _AppointmentPage extends State<AppointmentPage> {
  late Doctor doctor;
  var tarihStr;
  var _selectedDateTime;
  var timetwo;
  bool? muz;
  Color colorssaat = Colors.grey;

  @override
  void initState() {
    super.initState();
    doctor = AppointmentPage.doctor!;
    print(doctor.firstName);
  }

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.cyan,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 26),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: homepagefont,
      appBar: AppBar(
        backgroundColor: kBkrColor,
        title: Text("Randevu Al"),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          // Burada her gün için ayrı bir tarih değeri hesaplanır.
          // Örneğin bugünden itibaren 7 gün sonrasına kadar olan tarihler hesaplanır.
          final tarih = DateTime.now().add(Duration(days: index));
          final tarihStr = DateFormat('yyyy-MM-dd').format(tarih);
          final saatDilimleri = List.generate(8, (index) => '${9 + index}:00')
              .map((saat) => FutureBuilder(
              future: MongoDataBase.appointmentsorgu(tarihStr, saat,doctor?.id?.$oid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () async {
                      bool isAppointmentAvailable = await MongoDataBase.appointmentsorgu(tarihStr, saat,doctor?.id?.$oid);
                      if(isAppointmentAvailable){
                        setState(() {
                          colorssaat = Colors.black;
                          timetwo = "$saat";
                          _selectedDateTime = '$tarihStr $saat';
                          print(_selectedDateTime);
                          MongoDataBase.appointment(
                              tarihStr, timetwo, doctor?.id?.$oid);
                        });
                      }

                    },
                    child: Text(
                      saat,
                      style: TextStyle(fontSize: 16, color:colorssaat/* !snapshot.hasData && !isAppointmentAvailable ? Colors.grey : Colors.black,*/),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        timetwo = "$saat";
                        _selectedDateTime = '$tarihStr $saat';
                        print(_selectedDateTime);
                        MongoDataBase.appointment(
                            tarihStr, timetwo, doctor?.id?.$oid);
                      });
                    },
                    child: Text(
                      saat,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                        snapshot.hasData ? Colors.grey : Colors.black,
                      ),
                    ),
                  );
                }
              }))
              .toList();
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('yyyy, dd MMMM').format(tarih),
                  style: theme.textTheme.subtitle1,
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: saatDilimleri,
                ),
              ],
            ),
          );
        },
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
