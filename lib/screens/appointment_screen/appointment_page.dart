import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telesaglikk/constants.dart%20';

import '../../MongoDb.dart';
import '../../models/doctors_model.dart';

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
              future: MongoDataBase.appointmentsorgu(tarihStr, saat),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () async {
                      bool isAppointmentAvailable = await MongoDataBase.appointmentsorgu(tarihStr, saat);
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
    );
  }
}
