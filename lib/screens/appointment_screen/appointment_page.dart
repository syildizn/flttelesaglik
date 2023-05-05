import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telesaglikk/constants.dart%20';

import '../../MongoDb.dart';
import '../../models/doctors_model.dart';

class AppointmentPage extends StatefulWidget{
  static String routeName = 'AppointmentPage';
  static Doctor? doctor;



  @override
  State<StatefulWidget> createState() {
  print(doctor?.firstName);
    // TODO: implement createState
    return _AppointmentPage();
  }

}

class _AppointmentPage extends State<AppointmentPage>{
  late Doctor doctor;
  var tarihStr;
  var _selectedDateTime;
  var timetwo;

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
      backgroundColor: homepagefont ,
      appBar: AppBar(
        title: Text("Randevu Al"),
      ),
      body:ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          // Burada her gün için ayrı bir tarih değeri hesaplanır.
          // Örneğin bugünden itibaren 7 gün sonrasına kadar olan tarihler hesaplanır.
          final tarih = DateTime.now().add(Duration(days: index));
          final tarihStr = DateFormat('yyyy-MM-dd').format(tarih);

          // Burada her gün için ayrı saat dilimleri oluşturulur.
          final saatDilimleri = List.generate(8, (index) => '${9 + index}:00')
              .map(
                (saat) => FutureBuilder(
                  future: MongoDataBase.appointmentsorgu(_selectedDateTime),
                  builder: (context,snapshot) {
                    if (snapshot.hasData) {
                      bool variable = snapshot.hasData ? snapshot.data == null : true;
                      return InkWell(
                      onTap: variable ? () async {
                        // await MongoDataBase.appointment(
                        //     _selectedDateTime, "saat", doctor?.id?.$oid);
                         setState(() async {
                         timetwo = "$saat";
                         _selectedDateTime = '$tarihStr $saat';
                         print(_selectedDateTime);
                         await MongoDataBase.appointment(
                         _selectedDateTime, timetwo, doctor?.id?.$oid);
                         });
                        }: null,
                        child: Text(
                          saat,
                          style: TextStyle(fontSize: 12,
                          color: Colors.black),
                        )

                      );}
                    else {
                      return CircularProgressIndicator();
                    }
                    }

                ),
          )
              .toList();

          return Column(
            children: [
              sizedBox,
              Text(tarihStr,style: TextStyle(fontSize: 27,color: Colors.black),),
              sizedBox,// Tarihi ekrana yazdırırız.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: saatDilimleri,
              ), // Her gün için ayrı saat dilimi tuşları oluşturulur.
            ],
          );
        },
      ),
    );
  }
}